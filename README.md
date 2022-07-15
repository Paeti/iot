
<p align="center"> 
  <img src="images/Project Logo.png" alt="HAR Logo" width="80px" height="80px">
</p>
<h1 align="center"> Vorhersage von Verkehrsvolumen </h1>
<h3 align="center"> Analyse von Verkehrsdaten mit Zeitreihenmodellen </h3>  

</br>

<p align="center"> 
  <img src="images/Signal.gif" alt="Sample signal" width="70%" height="70%">
</p>

<!-- TABLE OF CONTENTS -->
<h2 id="table-of-contents"> :book: Table of Contents</h2>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project"> ➤ Über das Projekt</a></li>
    <li><a href="#prerequisites"> ➤ Voraussetzungen</a></li>
    <li><a href="#folder-structure"> ➤ Ordner Struktur</a></li>
    <li><a href="#dataset"> ➤ Nutzung</a></li>
    <li><a href="#roadmap"> ➤ Zukünftig</a></li>
    <li><a href="#references"> ➤ References</a></li>
    <li><a href="#contributors"> ➤ Contributors</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
<h2 id="about-the-project">  About The Project</h2>

<p align="justify"> 
  Beschreibung Projekt

(bildquelle =><!-- "https://www.autobahn.de/fileadmin/user_upload/Dialogforum_-_3._Sitzung_-_Gesamt.pdf")-->
</p>

<p align="center">
  <img src="img/verkehrsfluss_steuerung.jpg" alt="Table1: 18 Activities" width="70%" height="70%">        
  <!--figcaption>Caption goes here</figcaption-->
</p>


<!-- PREREQUISITES -->
<h2 id="prerequisites">  Prerequisites</h2>

[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)]() <br>
[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/) <br>
[![Made withJupyter](https://img.shields.io/badge/Made%20with-Jupyter-orange?style=for-the-badge&logo=Jupyter)](https://jupyter.org/try) <br>
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)]() <br>
[![Packer](https://img.shields.io/badge/packer-%23E7EEF0.svg?style=for-the-badge&logo=packer&logoColor=%2302A8EF)]() <br>
[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)]() <br>
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)]() <br>

Das gesamte Projekt wird über die Versionskontroll-Plattform "github" verwaltet. Da einige Dateien größer als die eigentlich von github
zugelassene Größe von 100 MB sind, ist es notwendig das Werkzeug "git lfs" (Git Large File Storage) zu nutzen. Die Webseite von git lfs 
bietet [detaillierte Anweisungen](https://git-lfs.github.com/) zur Installation und Nutzung. Um das Repository mit allen Dateien zu klonen 
ist es notwendig, dass git lfs 
installiert ist. Da die für das Training der Modelle notwendige Hardware nicht vorhanden war, wurde Cloudinfrastruktur genutzt.
Als Anbieter wurde [Amazon Web Services (aws)](https://aws.amazon.com/) gewählt. Um den Versuch zu reproduzieren ist es daher notwendig Zugriff 
auf einen AWS-Account
mit den entsprechenden Rechten zu haben. Auf der Webseite von AWS gibt es eine [Anleitung](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html), 
wie ein neuer Account erstellt werden kann.
Die Bereistellung der Cloudressourcen wurde mit Hilfe von zwei ["Infrastructure as Code" (IaC)](https://en.wikipedia.org/wiki/Infrastructure_as_code) 
Werkzeugen automatisiert. Diese Werkzeuge benötigen einen
API-Schlüssel um sich bei AWS authentifizieren zu können. Diese [Anleitung](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/) 
auf der Webseite von AWS zeigt, wie man einen solchen API-Schlüssel für
seinen Account erzeugen kann. Um die Nutzung dieser 
Werkzeuge zu vereinfachen wird empfohlen das ["aws-cli"](https://github.com/aws/aws-cli) Werkzeug zu installieren. 
Mit Hilfe vom aws-cli ist es möglich AWS Identitäten und die 
dazugehörigen Schlüssel zu verwalten, sowie über die Kommandozeile Cloudressourcen und deren Lebenszyklus zu verwalten. Für den hier beschriebenen
Versuchsaufbau wird nur die Fähigkeit der Identitäts- und Schlüsselverwaltung benötigt. Die beiden Werkzeuge bieten nämlich die Möglichkeit,
sich die benötigten Schlüssel aus der vom aws-cli verwalteten Identitätsdatei zu holen. So ist es nicht notwendig die Schlüssel im Klartext
in den Template Dateien der beiden Werkzeuge zu speichern, die ebenfalls in diesem Repository liegen. Anschließend müssen die beiden IaC Werkzeuge, 
[Packer](https://www.packer.io/) und [Terraform](https://www.terraform.io/)
installiert werden. Eine Anleitung, wie sie installiert werden können, findet sich jeweils auf der 
[Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) und [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) Webseite.
Bei Packer handelt es sich um ein Werkzeug, welches zum Erstellen von VM-Images genutzt wird. Für diese Experimente besteht der Anwendungsfall darin, VM-Images zu packen,
die alle notwendigen Abhängigkeiten bereits installiert haben. So ist es beim wiederholten durchführen, oder beim späteren Versuch das Experiment zu reproduzieren,
nicht nötig das System, auf dem die Experimente durchgeführt werden per Hand aufzusetzen. Das VM-Image Format das AWS nutzt nennt sich "Amazon Machine Image" (AMI).
Um ein solches Image zu erzeugen startet Packer eine VM auf AWS und führt die im Packer Template beschriebenen Schritte auf dieser VM aus. Anschließend wird
ein Snapshot des Systems auf AWS gespeichert. Dieser Snapshoot kann dann zum starten anderer VM's genutzt werden.
Das Erzeugen dieses VM-Images beinhaltet den Schritt, dass dieses Repository gepullt und auf dem System abgespeichert wird. Dazu ist es notwendig
das die VM auf AWS Zugang zum Repository hat. Für Programmgesteuerten Zugriff bieten sich SSH-Schlüssel an. Diese 
[Anleitung](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) zeigt, wie man einen SSH-Schlüssel erzeugt
und zu seinem Github Repository hinzufügt 

Packer bietet die Möglichkeit Anfragen an den SSH-Agenten der VM in der Cloud an den SSH-Agenten des Systemes 
weiterzuleiten, von dem aus das Erzeugen des VM-Images gestartet wurde. Damit dies von Seiten des SSH-Clients erlaubt wird muss eine Konfiguration des Clients vorgenommen werden.
Dazu muss in der Datei "~/.ssh/config" folgender Eintrag gespeichert werden:

<!-- BILD !!!!!! -->

===> zusätzlich ssh agent starten und schlüssel unter seine verwaltung stellen!!!!!!



Nachdem Terraform installiert wurde benötigt es keine weiteren Konfigurationen oder Abhängigkeiten.

Die für die Auswertung der Experimentergebnisse benötigten Daten und Abbildungen werden mit Hilfe eines Jupyter Notebooks und einiger Python Bibliotheken erzeugt.
Es wird empfohlen diese Bibliotheken in ein Python Virtualenvironment zu installieren. Dieses Repository enthält requironment.txt Dateien, mit denen die Experiment 
und Auswertungsumgebungen installiert werden können. Für die einfache Reproduktion dieser Umgebungen reichen ein 
[Virtualenvironment](https://docs.python.org/3/tutorial/venv.html) und der Python Paketmanager 
[pip](https://pypi.org/project/pip/)
vollkommen aus. Sollten jedoch zusätzliche Pakete oder andere Versionen von bereits installierten Paketen neu installiert werden soll, wird nachdrücklich empfohlen
das Werkzeug [pipenv](https://pipenv-fork.readthedocs.io/en/latest/) zu nutzen. Dieses Werkzeug prüft automatisch die Abhängighkeiten unter den verscheidenen Paketen und ihren Abhängigkeiten und wählt für den Anwender
eine passende Kombination aus. Da für die Experimente so viele verscheidene Bibliotheken installiert werden mussten hat es wiederholt Probleme gegeben, trotz der 
Nutzung dieses Werkzeuges. Nur mit pip wäre es deutlich schwieriger gewesen. pipenv nutzt Pipfile's und Pifile-locks's um die Informationen
über die Pakete und deren Abhängigkeiten zu speichern.


<!-- FOLDER STRUCTURE -->
<h2 id="folder-structure">  Folder Structure</h2>



<!-- Nutzung -->
<h2 id="dataset"> Nutzung</h2>

Der erste Schritt zum Aufsetzen der Experimentumgebung besteht im Erzeugen des VM-Images für die Maschiene, auf der die Experimente durchgeführt werden.
Die Zeitreihenmodelle werden mit der AutoML Bibliothek AutoTS trainiert und ausgewählt. Diese Bibliothek ermöglich die Anbindung verschiedener ML Bibliotheken.
Manche dieser Bibliotheken beinhallten Neuronale Netze. Wird AutoTS mit diesen Bibliotheken auf einer Maschiene
ohne Grafikkarte genutzt, kann das Training der verschiedenen Modelle und die 
Hyperparameteroptimierung mehrere Tage benötigen. Daher stellt dieses Repository jeweils ein Packer-Template zum Erzeugen eines VM-Images für eine Maschiene mit 
und ohne Grafikkarte zur Verfügung. Das Template für die Maschiene mit Grafikkarte weist zur Zeit noch Fehler auf. Alle benötigte Software wird installiert, es
treten beim Modelltraining von Neuronalen Netzen jedoch schwerwiegende Fehler auf, die zum Trainingsabbruch führen. Aus diesem Grund wird empfohlen das CPU-Image 
zu bauen und zu nutzen. Es wird jedoch gleichzeitig davon abgeraten die Neuronalen Netze mit Hilfe dieses VM-Images zu trainieren. Dies kann zu hohen AWS 
Rechnungen führen!

###  AWS-AMI mit Packer bauen

Damit Packer sich mit Ihrer AWS-Cloud verbinden kann um das AMI zu bauen, sollte ihre Zugangsdaten für den einmaligen Befehl im Environment der Shell sein.

```shell-session

export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"

export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRET_ACCESS_KEY>"

```

Um das CPU-Image zu bauen muss als erstes in den entsprechenden Ordner gewechselt werden:

```bash
cd packer/cpu
```



In diesem Ordner befindet sich das zugehörige Template. Dieses kann ohne weitere Änderungen direkt benutzt werden. Zur Zeit das Template so eingestellt,
dass zum erzeugen des Images eine m5.4xlarge Instanz auf AWS genutzt wird. Falls ein anderer Instanztyp genutzt werden soll kann dies über die Variable
"instance\_type" geändert werden.
Anschließend sollten folgende Befehle ausgeführt werden:

```bash
packer fmt .
```

Mit hilfe dieses Befehls wird das Template formatiert. Sollten Änderungen vorgenommen worden sein, kann dies zu besserer Lesbarkeit führen.

```bash
packer validate .
```

Mit Hilfe dieses Befehls wird validiert, dass das Template Syntaktisch korrekt ist. Auf diese Weise können Fehler abgefangen werden, bevor
Cloudressourcen gestartet werden und somit Geld kosten.

Zum Erzeugen des AMI's wird folgender Befehl genutzt:

```bash
packer build aws-dlami-autots-cpu.pkr.hcl
```

Sollten Änderungen vorgenommen worden sein, wired empfohlen die Erzeugung im Debug-Modus zu starten:

```bash
packer build -debug aws-dlami-autots-cpu.pkr.hcl
```

Auf diese Weise muss bei jedem Schritt vom Anwender bestätigt werden, das er durchgeführt werden soll. Packer erzeugt immer temporäre SSH-Schlüssel
um auf die VM, auf der das Template ausgeführt und das VM-Image erzeugt wird, zugreifen zu können. Ist der Debug-Modus aktiviert,
kann das direkte herunterfahren der VM nach einem fehler durch das nicht Bestätigen der Aktion verhindert werden. Dann befindet sich im Ordner packer/cpu
ein SSH-Schlüssel, mit dem man sich mit der VM verbinden kann und prüfen kann, was der Fehler war.

Wenn die Erzeugung des Images abgeschlossen ist, bekommt man die AMI-ID des erzeugten Images auf der Kommandozeile ausgegeben. Man kann sie ebenfalls über
die AWS-Konsole unter dem EC2 Service und dem Punkt AMI nachschauen.
Diese AMI-ID wird im nächsten Schritt genutzt werden, um mit diesem AMI eine VM auf AWS zuu starten.



  

###  Infrastruktur mit Terraform bauen

Um Cloudressourcen zu starten und deren Lebenszyklus zu verwalten wird Terraform genutzt. Alle nötigen Templates für Terraform befinden sich im
Ordner <repository-root>/terraform. Mit folgendem Befehl wechselt man vom Packer in den Terraform Ordner:

```bash
cd ../../terraform
```

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

###  Verbinden zur VM über SSH

In ihrem terraform-Verzeichnis ist nun nach ausführen des Skripts ein Schlüssel im PEM-Format generiert worden.

Die machen Sie am besten über den Befehl

```shell-session

ssh -i "<key-name>.pem" ubuntu@<server-name>

```

Schlüssel und Servernamen entnehmen Sie aus dem Output des ausgeführten terraform-Skripts.

Achten Sie dabei, dass die Berechtigungen des Schlüssels nicht zu Konflikten führen.

  

###  Starten des Trainings

Sobald sie auf der VM über SSH eingeloggt sind gehen Sie in das Trainingsverzeichnis mit

  

```shell-session

cd /home/ubuntu/iot/experiments

```

und starten schließlich das Training mit

  

```shell-session

./start_training.sh

```

  

Sobald das Training abgeschlossen ist schaltet sich der Server automatisch runter und







<!-- CONTRIBUTORS -->
<h2 id="contributors">  Contributors</h2>

<p>
  :boy: <b>Patrick Reckeweg</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>patrick.reckeweg@stud.h-da.de</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/Paeti">@Paeti</a> <br>

  :boy: <b>Alfred Oshana</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>alfredashur.oshana@stud.h-da.de</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/oalfreda">@oalfreda</a> <br>
</p>



<br>
✤ <i>Eine Abschlussarbeit für den Kurs 22SS IoT Technologien an der <a href="https://h-da.de/">Hochschule Darmstadt</a><i>

✤ <a href="https://github.com/ma-shamshiri">@ma-shamshiri</a> für die <a href="https://github.com/ma-shamshiri/Human-Activity-Recognition/blob/main/README.md">Markdown-Vorlage</a>
