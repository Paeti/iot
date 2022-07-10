import os
import shutil
import pandas as pd
import numpy as np
import pickle

from datetime import date
from autots import AutoTS


def prepare_filesystem_for_saving_results():
    for junction_number in range(1, 5):
        junction_result_folder = "./results_per_junction/junction_{0}".format(
                junction_number
                )

        if not os.path.exists(junction_result_folder):
            os.makedirs(junction_result_folder)
            print("Directory {0} succesfully created.".format(
                junction_result_folder)
                )
        else:
            print("Directory {0} already exists.".format(junction_result_folder))

    for junction_result_folder in os.listdir("./results_per_junction"):
        try:
            os.mkdir("./results_per_junction/{0}/model".format(
                junction_result_folder)
                )
            os.mkdir("./results_per_junction/{0}/result_plots".format(
                junction_result_folder)
                )
            os.mkdir(
                "./results_per_junction/{0}/"
                "result_table_as_latex".format(junction_result_folder)
            )
            print(
                "Directories ./results_per_junction/{0}/model,"
                " ./results_per_junction/{0}/result_plots"
                "and ./results_per_junction/{0}/result_table_as_latex"
                " successfully created.".format(junction_result_folder)
            )
        except FileExistsError:
            print(
                "Directories ./results_per_junction/{0}/model and"
                " ./results_per_junction/{0}/result_plots"
                " already existed.".format(junction_result_folder)
            )

    try:
        os.mkdir("./combined_result_plots")
        print("Directory ./combined_result_plots successfully created.")
    except FileExistsError:
        print("Directory ./combined_result_plots already existed")


def cleanup_filesystem():
    try:
        shutil.rmtree("./combined_result_plots")
    except OSError as e:
        print("Error: {0} : {1}".format(
            "./combined_result_plots", 
            e.strerror)
            )

    try:
        shutil.rmtree("./results_per_junction")
    except OSError as e:
        print("Error: {0} : {1}".format("./results_per_junction", e.strerror))


def save_autots_model_results_per_junction(autots_model_junction_key_list):
    for model, key in autots_model_junction_key_list:
        filename = ("junction_{0}_trained_autots_model_junction_"
                    "number_tuple.bin").format(key)

        working_directory =os.getcwd()
        base_path = "results_per_junction/junction_{0}/model".format(key)

        complete_path = "/".join([working_directory, base_path, filename])

        with open(complete_path, "wb") as f: # "wb" because we want to write in binary mode
            pickle.dump((model, key), f)


def save_best_model_per_junctions_backforecast(
    best_model_junction_num_tuple_list,
    time_series_data,
):
    
    time_series_data_groups = time_series_data.groupby(["Junction"])

    
    for model, junction_num in best_model_junction_num_tuple_list:
        filename = ("junction_{0}_best_trained_model_junction_"       
                    "backforecast.csv").format(junction_num)
        
        working_directory =os.getcwd()
        base_path = "results_per_junction/junction_{0}/autots_model".format(junction_num)
        
        complete_path = "/".join([working_directory, base_path, filename])
        
        junction_data = time_series_data_groups.get_group(junction_num)["Vehicles"]
        
        junction_backforecast = model.back_forecast(
            column = "Vehicles",
            n_splits = "auto",
        ).forecast
        
        junction_backforecast.to_csv(complete_path)


def train_models_per_junction(data_grouped_by_junction, autots_param_dict):
    result_model_junction_key_list = []
    
    for key, group in data_grouped_by_junction:
        group.drop(["Junction"], axis=1, inplace=True)
        group["Vehicles"] = group["Vehicles"].astype("float64")

        autots_model = AutoTS(**autots_param_dict)

        junction_resulting_model = autots_model.fit(group)
        
        result_model_junction_key_list.append(
                (junction_resulting_model, key)
                )
        
    return result_model_junction_key_list


if __name__ == "__main__":
    data = pd.read_csv(
            "../data/traffic.csv", 
            parse_dates=True, 
            index_col="DateTime"
            )
    data.drop(["ID"], axis=1, inplace=True)
    data_grouped_by_junction = data.groupby(by="Junction")

    model_list = [
        "DatepartRegression",
        "GluonTS",
        "MotifSimulation",
        "Greykite",
        "PytorchForecasting",
        "ARCH",
        "NeuralProphet",
        "NVAR",
        "SectionalMotif",
        "UnivariateMotif",
        "UnivariateRegression",
        "WindowRegression",
        "RollingRegression",
        "ARDL",
        "Theta",
        "ARIMA",
        "ETS",
        "UnobservedComponents",
        "GLS",
        "GLM",
    ]

    autots_param_dict = {
        "forecast_length": 5,
        "frequency": "H",
        "prediction_interval": 0.9,
        "ensemble": None,
        "model_list": model_list,
        "transformer_list": "all",
        "models_to_validate": 0.35,
        "max_generations": 15,
        "num_validations": 5,
        "validation_method": "backwards",
        "n_jobs": 8,
        "no_negatives": True,
        "holiday_country": "US",
        "current_model_file": "./model_rescue",
    }

    cleanup_filesystem()

    resulting_models = train_models_per_junction(
            data_grouped_by_junction, 
            autots_param_dict
            )

    prepare_filesystem_for_saving_results()
    save_autots_model_results_per_junction(resulting_models)
    save_best_model_per_junctions_backforecast(resulting_models, data)
