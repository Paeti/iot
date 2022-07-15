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

!!!!!!!!!!!!!!!! => fork von dem hier damit funzt?!?!?!!

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

Um Cloudressourcen zu starten und deren Lebenszyklus zu verwalten wird Terraform genutzt. Alle nötigen Templates für Terraform befinden sich im
Ordner <repository-root>/terraform. Mit folgendem Befehl wechselt man vom Packer in den Terraform Ordner:

```bash
cd ../../terraform
```





<!-- ROADMAP -->
<h2 id="roadmap"> Zukünftig</h2>

<p align="justify"> 
  Weiss et. al. has trained three models namely Decision Tree, k-Nearest Neighbors, and Random Forest for human activity classification by preprocessing the raw time series data using statistical feature extraction from segmented time series. 
  The goals of this project include the following:
<ol>
  <li>
    <p align="justify"> 
      Train the same models - Decision Tree, k Nearest Neighbors, and Random Forest using the preprocessed data obtained from topological data analysis and compare the
      performance against the results obtained by Weiss et. al.
    </p>
  </li>
  <li>
    <p align="justify"> 
      Train SVM and CNN using the preprocessed data generated by Weiss et. al. and evaluate the performance against their Decision Tree, k Nearest Neighbors, and Random Forest models.
    </p>
  </li>
</ol>
</p>




<!-- REFERENCES -->
<h2 id="references"> References</h2>

<ul>
  <li>
    <p>Matthew B. Kennel, Reggie Brown, and Henry D. I. Abarbanel. Determining embedding dimension for phase-space reconstruction using a geometrical construction. Phys. Rev. A, 45:3403–3411, Mar 1992.
    </p>
  </li>
  <li>
    <p>
      L. M. Seversky, S. Davis, and M. Berger. On time-series topological data analysis: New data and opportunities. In 2016 IEEE Conference on Computer Vision and Pattern Recognition Workshops (CVPRW), pages 1014–1022, 2016.
    </p>
  </li>
  <li>
    <p>
      Floris Takens. Detecting strange attractors in turbulence. In David Rand and Lai-Sang Young, editors, Dynamical Systems and Turbulence, Warwick 1980, pages 366–381, Berlin, Heidelberg, 1981. Springer Berlin Heidelberg.
    </p>
  </li>
  <li>
    <p>
      Guillaume Tauzin, Umberto Lupo, Lewis Tunstall, Julian Burella P´erez, Matteo Caorsi, Anibal Medina-Mardones, Alberto Dassatti, and Kathryn Hess. giotto-tda: A topological data analysis toolkit for machine learning and data exploration, 2020.
    </p>
  </li>
  <li>
    <p>
      G. M. Weiss and A. E. O’Neill. Smartphone and smartwatchbased activity recognition. Jul 2019.
    </p>
  </li>
  <li>
    <p>
      G. M. Weiss, K. Yoneda, and T. Hayajneh. Smartphone and smartwatch-based biometrics using activities of daily living. IEEE Access, 7:133190–133202, 2019.
    </p>
  </li>
  <li>
    <p>
      Jian-Bo Yang, Nguyen Nhut, Phyo San, Xiaoli li, and Priyadarsini Shonali. Deep convolutional neural networks on multichannel time series for human activity recognition. IJCAI, 07 2015.
    </p>
  </li>
</ul>


<!-- CONTRIBUTORS -->
<h2 id="contributors">  Contributors</h2>

<p>
  :mortar_board: <i>All participants in this project are graduate students in the <a href="https://www.concordia.ca/ginacody/computer-science-software-eng.html">Department of Computer Science and Software Engineering</a> <b>@</b> <a href="https://www.concordia.ca/">Concordia University</a></i> <br> <br>
  

  :woman: <b>Mahsa Sadat Afzali Arani</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>m_afzali93@yahoo.com</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/MahsaAfzali">@MahsaAfzali</a> <br>

  :boy: <b>Mohammad Amin Shamshiri</b> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email: <a>mohammadamin.shamshiri@mail.concordia.ca</a> <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/ma-shamshiri">@ma-shamshiri</a> <br>
</p>

<br>
✤ <i>This was the final project for the course COMP 6321 - Machine Learning (Fall 2020), at <a href="https://www.concordia.ca/">Concordia University</a><i>
