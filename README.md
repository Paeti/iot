# Cloud-Infrastruktur für die Technologiestudie: "Analyse von Verkehrsdaten mit Zeitreihenmodellen"

## Ausführung


### AWS-AMI mit Packer bauen

Damit Packer sich mit Ihrer AWS-Cloud verbinden kann um das AMI zu bauen, sollte ihre Zugangsdaten für den einmaligen Befehl im Environment der Shell sein.
```shell-session

export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRET_ACCESS_KEY>"

```

Als Nächstes manövrieren Sie in das Packerverzeichnis GPU oder CPU. Jenachdem, wie Sie Ihre Modelle trainieren möchten und fangen an Packer zu initialisieren.
```shell-session
packer init .
```
Danach formatieren und validieren Sie das Packer-Skript mit
```shell-session
packer fmt .
packer validate .
```
und schließlich bauen Sie das Image mit

```shell-session
packer build aws-dlami-autots-cpu.pkr.hcl
```
bzw.
```shell-session
packer build aws-dlami-autots-gpu.pkr.hcl
```

### Infrastruktur mit Terraform bauen
Damit Terraform sich mit Ihrer AWS-Instanz verbinden kann sollten Sie in Ihrem Home-Verzeichnis ein .aws-Ordner haben welcher in einer credentials-Datei Ihre Zugangsdaten so abspeichert.
```txt
[terraform]
aws_access_key_id=<YOUR_AWS_ACCESS_KEY_ID>
aws_secret_access_key=<YOUR_AWS_SECRET_ACCESS_KEY_ID>
```
Unter Zeile 18 des jeweiligen Packer-Skripts findet sich der gegebene AMI-Name.
Dieser String soll nun von Ihnen in die Datei terraform/vars.tf bei Zeile 22 als default-Wert eingetragen werden.

Somit können Sie wenn Sie im terraform-Verzeichnis sind das Skript initialisieren mit
```shell-session
terraform init
```
und die Infrastruktur hochziehen mit
```shell-session
terraform apply
```
anschließend geben Sie "yes" in die Konsole und warten bis die Infrastruktur online ist.

cd /home/ubuntu/iot/experiments
### Verbinden zur VM über SSH
In ihrem terraform-Verzeichnis ist nun nach ausführen des Skripts ein Schlüssel im PEM-Format generiert worden.
Die machen Sie am besten über den Befehl
```shell-session
ssh -i "<key-name>.pem" ubuntu@<server-name>
```
Schlüssel und Servernamen entnehmen Sie aus dem Output des ausgeführten terraform-Skripts.
Achten Sie dabei, dass die Berechtigungen des Schlüssels nicht zu Konflikten führen.

### Starten des Trainings
Sobald sie auf der VM über SSH eingeloggt sind gehen Sie in das Trainingsverzeichnis mit

```shell-session
cd /home/ubuntu/iot/experiments
```
und starten schließlich das Training mit

```shell-session
./start_training.sh
```

Sobald das Training abgeschlossen ist schaltet sich der Server automatisch runter und 
