---
title: "Crashkurs Datenanalyse mit R"
author: "ifes and friend (Sebastian Sauer)"
tags:
- rstats
- tutorial
- German
layout: post
---






Nicht jeder liebt Datenanalyse und Statistik... in gleichem Maße! Das ist zumindest meine Erfahrung aus dem Unterricht 🔥. Crashkurse zu R sind vergleichbar zu Tanzkursen vor der Hochzeit: Hat schon vielen das Leben gerettet, aber ersetzt nicht ein Semester in der Pariser Tanzakademie (man beachte den Vergleich zum Unterricht an der FOM).

Dieser Crashkurs ist für Studierende oder Anfänger der Datenanalyse gedacht, die in kurzer Zeit einen verzweifelten Versuch ... äh ... einen grundständigen Überblick über die Datenanalyse erwerben wollen.

Ok, let's dance 🕺.


# Software

Bevor wir uns die Schritte näher anschauen, ein paar Worte zur Software. 

## Programme

Wir brauchen zwei Programme:

1. [R](https://cran.r-project.org/)  
2. [RStudio](https://www.rstudio.com/products/rstudio/download2/) (Desktop-Version)    


Bitte laden Sie diese herunter und installieren Sie sie. Wenn R installiert ist, dann findet RStudio R auch direkt. Wenn alles läuft, sieht es etwa so aus:

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/RStudio-Screenshot.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="50%" style="display: block; margin: auto;" />





__Warum R?__

* R ist ein Programm für Statistik und Datenanalyse.
* R ist für Linux, MacOS X und Windows (95 oder höher) Plattformen verfügbar.
* R ist eine elegante und umfassende statistische und grafische Programmiersprache. 
* R kann eine steile Lernkurve L haben `(L = Zeiteinheit/Erfolgseinheit)`. 
* R ist kostenlos! Wenn Sie Lehrender oder Studierender sind, sind die Vorteile offensichtlich.
* R bietet eine unvergleichliche Plattform für die Programmierung neuer statistischer Methoden in einer einfachen und unkomplizierten Weise.
* R enthält fortgeschrittene statistische Routinen, die noch nicht in anderen Software-Paketen verfügbar sind.
* R verfügt über state-of-the-art Grafiken Fähigkeiten.


__Warum RStudio?__

RStudio ist eine integrierte Entwicklungsumgebung (IDE), die die Verwendung von R für Anänfäger und Experten erleichtert.


## Erweiterungen



Um einen Befehl zu verwenden, der *nicht* im Standard-R, sondern in einer Erweiterung von R ("Paket") wohnt, müssen sie dieses Paket erst starten (laden). Dazu können Sie den Befehl `library` verwenden. Wir benötigen diese Pakete; bitte laden (d.h. Code ausführen):


```r
library(mosaic)  # Zugpferd
library(tidyverse)  # Datenjudo
library(ggformula)  # Malen
library(effects) # Effektplots für ANOVA-Modelle

```



Oder Sie klicken den Namen des Pakets hier an:


<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/packages_load.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="50%" style="display: block; margin: auto;" />



Wir gehen im Folgenden davon aus, dass Sie diese beiden Pakete geladen haben.

>    Nach *jedem* Start von R bzw. RStudio müssen Sie die Erweiterung erneut laden (wenn Sie sie benutzen wollen).

⚠️ Um ein Paket zu laden, muss es installiert sein. Klicken Sie zum Installieren auf den Button "Install" unter dem Reiter "Packages" in RStudio:

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/install_packages.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="50%" style="display: block; margin: auto;" />



>    Sie müssen ein Paket nur *einmal* installieren, um es verwenden zu können. Sie installieren ja auch nicht Ihren Browser jedes Mal neu, wenn Sie den Computer starten.


Starten Sie jetzt die beiden Erweiterungen (per Klick oder mit folgenden Befehlen).


```r
library(mosaic)
library(tidyverse)
```


## Daten

Wir verwenden in diesem Kurs diese Datensätze:

- `mtcars`
- `tips` 

`mtcars` ist schon im Standard-R fest eingebaut; Sie müssen also nichts weiter tun. Den Datensatz `tips` können Sie [hier](https://sebastiansauer.github.io/data/tips.csv) herunterladen.



🔖 Lesen Sie hier weiter, um Ihr Wissen zu vertiefen zu diesem Thema: [R - Software in stallieren](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/daten-einlesen.html).



# Über sieben Brücken musst Du gehen

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/Peter_Maffay.jpg" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="20%" style="display: block; margin: auto;" />


  
Lizenz: André D Conrad, CC BY SA 3.0 De, https://de.wikipedia.org/wiki/Peter_Maffay#/media/File:Peter_Maffay.jpg

Man kann (wenn man will) die Datenanalyse in ~~sieben~~ fünf Brücken oder Schritte einteilen, angelehnt dem Song von Peter Maffay "Über sieben Brücken musst du gehen".


<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/Prozess.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="50%" style="display: block; margin: auto;" />




# Arbeiten mit dem Paket `mosaic`


Das Paket `mosaic` wird unser Zugpferd für alle folgenden Analysen ein. Es hat den Charme, über eine einfache, konsistente Syntax zu verfügen. Mit wenig kann man da viel erreichen. Genau das, wovon man als Student träumt... (so denken Dozenten, jedenfalls).

Die folgende Syntax 

> Zielbefehl(y ~ x | z, data=...)

wird verwendet für 

* graphische Zusammenfassungen,
* numerische Zusammenfassungen und 
* inferentstatistische Auswertungen


Für Grafiken gilt:

* y: y-Achse Variable
* x: x-Achse Variable
* z: Bedingungsvariable
    

Generell gilt:

> `y ~ x | z` 

kann in der Regel gelesen werden **y wird modelliert von (oder hängt ab von) x unterschieden für jedes z**.


Der Kringel (die Tilde) `~` erzeugt sich beim Mac mit `ALT+n` und bei Windows steht es auf einer Taste ziemlich rechts auf der Tastatur. Die Verwendung der Tilde wird auch als "Formel-Schreibweise" (engl. "Formula Interface") bezeichnet.


# Brücke 1: Daten einlesen

Der einfachste Weg, Daten einzulesen, ist über den Button "Import Dataset" in RStudio.



So lassen sich verschiedene Formate - wie XLS(X) oder CSV - importieren.

⚠️ Beim Importieren von CSV-Dateien ist zu beachten, dass R davon von *us-amerikanisch* formatierten CSV-Dateien ausgeht. Was heißt das? Das bedeutet, das Spaltentrennzeichen (delimiter) ist ein Komma `,`. *Deutsch* formatierte CSV-Dateien, wie sie ein deutsch-eingestelltes Excel ausgibt, nutzen aber ein Semikolon `;` (Strichpunkt) als Spaltentrennzeichen.

Haben Sie also eine "deutsche" CSV-Datei, müssen Sie in der Import-Maske von RStudio als *delimiter* ein *semicolon* auswählen.

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/delimiter.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" width="50%" style="display: block; margin: auto;" />




Den Tips-Datensatz können Sie einfach importieren, indem Sie in der Maske in RStudio den Link `https://sebastiansauer.github.io/data/tips.csv` eingeben. Oder per Befehl, geht genauso schnell:


```r
tips <- read.csv("https://sebastiansauer.github.io/data/tips.csv")
```


Alternativ können Sie natürlich eine XLS- oder XLSX-Datei importieren. Am einfachsten ist es, XLSX-Dateien zu importieren.






## tidy data - Tabellen in Normalform

Damit Sie in R vernünftig mit Ihren Daten arbeiten können, sollten die Daten "tidy" sein, d.h. in *Normalform*. Was ist Normalform? Betrachten Sie folgende Abbildung - so sieht eine Tabelle in Normalform aus.

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/Normalform.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" width="50%" style="display: block; margin: auto;" />



Die goldene Regel der Normalform einer Tabelle lautet also:

>   In jeder Zeile steht eine Beobachtung (z.B. Person). In jeder Spalte eine Variable (z.B. Geschlecht). In der ersten Zeile stehen die Spaltennamen, danach folgen die Werte. Sonst steht nichts in der Tabelle.


⚠️ Falls Ihre Daten *nicht* in Normalform sind, sollten Sie diese zunächst in Normalform bringen. 

💡 Der einfachste Weg (von der Lernkurve her betrachtet, nicht vom Zeitaufwand), Daten in Normalform zu bringen, ist sie in Excel passend umzubauen.

## Beispiel für Daten in Nicht-Normalform

Sie denken, dass Ihre Daten immer/auf jeden Fall in Normalform sind? Dann schauen Sie sich mal dieses Bild an:

<img src="(https://sebastiansauer.github.io/images/2017-05-16/figure/breit_lang.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" width="50%" style="display: block; margin: auto;" />




Wir werden in diesem Kurs nicht bearbeiten, wie man Daten von "breit" auf "lang" (=tidy) umformatiert. Aber lesen Sie bei Interesse doch z.B. [hier](https://sebastiansauer.github.io/facial_beauty/) nach.


## Daten anschauen

Es empfiehlt sich, zu Beginn einne Blick auf die Daten zu werfen, um zu prüfen, ob alles augenscheinlich seine Richtigkeit hat. Tun Sie das immer, viel Ärger lässt sich so ersparen.


```r
glimpse(mtcars)
#> Observations: 32
#> Variables: 11
#> $ mpg  <dbl> 21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19....
#> $ cyl  <dbl> 6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8, 8, 8, 8, 8, 8, 4, 4, ...
#> $ disp <dbl> 160.0, 160.0, 108.0, 258.0, 360.0, 225.0, 360.0, 146.7, 1...
#> $ hp   <dbl> 110, 110, 93, 110, 175, 105, 245, 62, 95, 123, 123, 180, ...
#> $ drat <dbl> 3.90, 3.90, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.9...
#> $ wt   <dbl> 2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190, 3...
#> $ qsec <dbl> 16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20.00, 2...
#> $ vs   <dbl> 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, ...
#> $ am   <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, ...
#> $ gear <dbl> 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, 4, ...
#> $ carb <dbl> 4, 4, 1, 1, 2, 1, 4, 2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, 2, ...
glimpse(tips)
#> Observations: 244
#> Variables: 8
#> $ X          <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, ...
#> $ total_bill <dbl> 16.99, 10.34, 21.01, 23.68, 24.59, 25.29, 8.77, 26....
#> $ tip        <dbl> 1.01, 1.66, 3.50, 3.31, 3.61, 4.71, 2.00, 3.12, 1.9...
#> $ sex        <fctr> Female, Male, Male, Male, Female, Male, Male, Male...
#> $ smoker     <fctr> No, No, No, No, No, No, No, No, No, No, No, No, No...
#> $ day        <fctr> Sun, Sun, Sun, Sun, Sun, Sun, Sun, Sun, Sun, Sun, ...
#> $ time       <fctr> Dinner, Dinner, Dinner, Dinner, Dinner, Dinner, Di...
#> $ size       <int> 2, 3, 3, 2, 4, 4, 2, 4, 2, 2, 2, 4, 2, 4, 2, 2, 3, ...
```



## Selber Daten erzeugen

Normalerweise werden Sie Daten in R einlesen, aber manchmal möchte man selber Daten erzeugen. Dazu sollten Sie wissen: Ein Dataframe besteht aus Spalten, wie Sie wissen. Diese Spalten nennt man auch *Vektoren*. Ein Vektor ist eine Sammlung von einzelnen Datenstücken, die hintereinander aufgereiht sind, wie Wäsche an der Wäscheleine. Ach ja, *Vektoren* müssen "sortenrein" sein, also nur Zahlen oder nur Text etc. Um einen Vektor zu erzeugen, benutzt man den Befehle `c` (wie combine oder concatenate, aneinanderfügen):


```r
meine_freunde <- c("Bibi", "Uschi", "Ulf", "Donald der Große")

Deine_PINs <- c(1234, 7777, 1234567, 0000)
```


💻 AUFGABE: 

1. Erzeugen Sie einen Vektor mit einem kreativen Namen.
2. Erzeugen Sie einen Vektor, in dem Sie Zahlen und Text mischen. Was passiert?
3. Erstellen Sie einen Vektor aus `meine_freunde` und `Deine_PINs`. Was passiert?


## Daten als CSV oder Excel exportieren

Wie kriege ich die Daten aus R wieder raus? Was ist sozusagen mit REXIT-Strategie? Keine Sorge, die Straße fährt in beide Richtungen. Sagen wir, Sie möchten den Dataframe `mtcars` exportieren, um außerhalb von R damit Kunststücke zu vollbringen:

### CSV


```r
write.csv(mtcars, "mtcars.xlsx")
```


### XLSX


```r
library(openxlsx)
write.xlsx(mtcars, "mtcars.xlsx")
```


## Das R-Arbeitsverzeichnis

💡 R schreibt Dateien immer in R R-Arbeitsverzeichnis. Sie wissen nicht, was das R-Arbeitsverzeichnis ist? Lesen Sie [hier](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/rahmen.html#wd) nach.


## Textkodierung in UTF-8

Falls Sie RStudio oder ein beliebiger Texteditor irgendwann fragt, wie die Textdatei kodiert sein soll, wählen Sie immer "UTF-8". UTF-8 ist eine Kodierungstabelle, so dass der Computer weiß, welches Zeichen welcher Taste zugeordnet ist; dabei ist UTF-8 so großzügig geplant, dass alle möglichen Sonderzeichen (Deutsch, Chinesisch, Hebräisch...) dazu passen. UTF-8 ist die Standard-Kodierung für Textdateien im Internet.


💡 In RStudio kann man unter `File..Save with Encoding...` die Textcodierung einstellen.





🔖 Lesen Sie hier weiter, um Ihr Wissen zu vertiefen zu diesem Thema: [Daten Einlesen mit Prada](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/daten-einlesen.html).





💻 AUFGABE: 

1. Prüfen Sie, in welchem Format Ihr Dokument kodiert ist.
2. Setzen Sie das Format ggf. auf UTF-8.




# Schritt 2: Aufbereiten

Der Schritt des Aufbereitens ist häufig der zeitintensivste Schritt. In diesem Schritt erledigen Sie alles, bevor Sie zu den "coolen" oder fortgeschrittenen Analysen kommen. Z.B.

- prüfen auf Fehler beim Daten einlesen (und korrigieren)
- Spaltennamen korrigieren
- Daten umkodieren
- Fehlende Werte verarzten
- Komische Werte prüfen
- Daten zusammenfassen
- Zeilenmittelwerte bilden
- Logische Variablen bilden



## Auf Fehler prüfen beim Einlesen

⚠️ Ein häufiger Fehler ist, dass die Daten nicht richtig eingelesen werden. Zum Beispiel werden die Spaltentrennzeichen nicht richtig erkannt. Das kann dann so aussehen:

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/delimiter_wrong.png" title="plot of chunk unnamed-chunk-17" alt="plot of chunk unnamed-chunk-17" width="50%" style="display: block; margin: auto;" />



Unter "delimiter" in der Maske können Sie das Trennzeichen anpassen. 

⚠️ "Deutsche" CSV-Dateien verwenden als *Dezimaltrennzeichen* ein Komma; englisch-formatierte CSV-Dateien hingegen einen Punk. R geht per Default von englisch-formatierten CSV-Dateien aus. Importieren Sie eine deutsch-formatierte CSV-Datei, müssen Sie das Dezimaltrennzeichen von Hand ändern; es wird nicht automatisch erkannt.

💡 Unter "locale" können Sie das Dezimaltrennzeichen ggf. anpassen.


## Spaltennamen korrigieren

Spaltennamen müssen auch "tidy" sein. Das heißt in diesem Fall:

- keine Leerzeichen
- keine Sonderzeichen (#,ß,ä,...)
- nicht zu lang, aber trotzdem informativ

>   Spaltennamen sollten nur Buchstaben (ohne Umlaute) und Ziffern enthalten. Für Textdaten in den Spalten sind diese Regeln auch sinnvoll.



💡 Am einfachsten ändern Sie die Spaltennamen in Excel.

In R können Sie Spaltennamen z.B. so ändern:


```r
rename(mtcars, PS = hp) -> mtcars
```

In Pseudo-R könnte man schreiben:

```
benenne_spalte_um(meine_tabelle, neuer_name = altername) -> meine_neue_tabelle
```


💻 AUFGABE: 

- Benennen Sie in `mtcars` die Spalte `mpg` in `spritverbrauch` um.
- Suchen Sie sich noch zwei weitere Spalten, und benennen Sie die Spaltennamen nach eigenen Vorstellungen um!



## Umkodieren

Gerade bei der Analyse von Fragebogendaten ist es immer wieder nötig, Daten umzukodieren. Klassisches Beispiel: Ein Item ist negativ kodiert. Zum Beispiel das Item "Ich bin ein Couch-Potator" in einem Fragebogen für Extraversion. 

Nehmen wir an, das Item "i04" hat die Werte 1 ("stimme überhaupt nicht zu") bis 4 ("stimme voll und ganz zu"). Kreuzt jemand das Couch-Potato-Item mit 4 an, so sollte er nicht die maximale Extraversion-Punktzahl (4), sondern die *minimale* Extraversion-Punktzahl (1) erhalten. Also

`
1 --> 4
2 --> 3
3 --> 2
4 --> 1
`

Am einfachsten ist dies zu bewerkstelligen mit folgendem R-Befehl:

```
meine_tabelle$i04_r <- 5 - meine_Tabelle$i04
```

Rechnet man `5-i04` so kommt der richtige, "neue" Wert heraus. 

Zur Erinnerung:

- `$` ist das Trennzeichen zwischen Tabellennamen und Spaltenname.
- `<-` ist der Zuweisungsbefehl. Wir definieren eine neue Spalte mit dem Namen `i04_r`. Das `r` soll stehen für "rekodiert", damit wir wissen, dass in dieser Spalte die umkodierten Werte stehen.



## Fehlende Werte

Der einfachste Umgang mit fehlenden Werten ist: nichts machen. Denken Sie nur daran, dass viele R-Befehle von Natur aus nervös sind - beim Anblick von fehlenden Werten werden sie panisch und machen nix mehr. Zum Beispiel der Befehl `mean`. Haben sie fehlende Werte in ihren Daten, so verwenden Sie den Parameter `na.rm = TRUE`. `na` steht für "not available", also fehlende Werte. `rm` steht für "remove". Also `mean(meine_tabelle$i04_r, na.rm = TRUE)`.

💡 Der R-Befehl `summary` zeigt Ihnen an, ob es fehlende Werte gibt:

`summary(meine_daten)`.



💻 AUFGABE:  

- Prüfen Sie, ob es in `mtcars` fehlende Werte gibt.
- Prüfen Sie, ob es in `tips` fehlende Werte gibt.




## Komische Werte

Hat ein Spaßvogel beim Alter 999 oder -1 angegeben, kann das Ihre Daten ganz schön verhageln. Prüfen Sie die Daten auf komische Werte. Der einfachste Weg ist, sich die Daten in Excel anzuschauen. Cleverer ist noch, sich Zusammenfassungen auszugeben, wie der kleinste oder der größte Wert, oder der Mittelwert etc., und dann zu schauen, ob einem etwas spanisch vorkommt. Diagramme sind ebenfalls hilfreich. Dann ändern Sie die Werte in Excel und laden die Daten erneut ins R.

## Nach Excel exportieren

💡 So kann man Daten als Excel-Datei (xlsx) exportieren:


```r
library(xlsx)
write.xlsx(mtcars, "mtcars.xlsx")
```

Dieser Befehl (`write.xlsx`) schreibt eine XLSX-Datei in das aktuelle R-Verzeichnis (das Arbeitsverzeichnis).



## Logische Variablen bilden

Sagen wir, uns interessiert welches Auto mehr als 200 PS hat; wir wollen Autos mit mehr als 200 PS vergleichen ("Spass") mit schwach motorisierten Autos ("Kruecke"). Wie können wir das (einfach) in R erreichen? Logische Variablen sind ein einfacher Weg.


```r
Spass <- mtcars$hp > 200
```

Dieser Befehl hat eine Spalte (Variable) in der Tabelle `mtcars` erzeugt, in der `TRUE` steht, wenn das Auto der jeweiligen Spalte die Bedingung (hp > 200) erfüllt. Schauen Sie nach.


```r
favstats(Spass)
#>  min Q1 median Q3 max mean sd n missing
#>   NA NA     NA NA  NA  NaN NA 0       0
```


💻 AUFGABE:

- Erstellen Sie eine Variable "schluckspecht", definiert als `TRUE`, wenn `mpg < 20`.
- Erstellen Sie eine Variable `kruecke`, definiert als TRUE, wenn `hp <= 200`.
- Denken Sie sich noch selber ein Beispiel aus.



## Daten zusammenfassen: Deskriptivstatistik

Deskriptive Statistik ist letztlich nichts anderes, als Daten geschickt zusammenzufassen. 

>   Praktisch wird meistens eine Spalte einer Tabelle zu einer Zahl zusammengefasst.

<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/summarise.png" title="plot of chunk unnamed-chunk-22" alt="plot of chunk unnamed-chunk-22" width="50%" style="display: block; margin: auto;" />






Schauen wir uns das mal mit echten Daten an. Der Datensatz "mtcars" ist schon in R eingebaut, so dass wir in nicht extra laden müssen. Ganz praktisch.



```r
summary(mtcars)
#>       mpg             cyl             disp             PS       
#>  Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
#>  1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
#>  Median :19.20   Median :6.000   Median :196.3   Median :123.0  
#>  Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
#>  3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
#>  Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
#>       drat             wt             qsec             vs        
#>  Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
#>  1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
#>  Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
#>  Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
#>  3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
#>  Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
#>        am              gear            carb      
#>  Min.   :0.0000   Min.   :3.000   Min.   :1.000  
#>  1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
#>  Median :0.0000   Median :4.000   Median :2.000  
#>  Mean   :0.4062   Mean   :3.688   Mean   :2.812  
#>  3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
#>  Max.   :1.0000   Max.   :5.000   Max.   :8.000
```

Hilfe zu diesem Datensatz bekommen Sie so:


```r
help(mtcars)
```

💡 mit `help(Befehl)` bekommt man Hilfe zu einem Befehl oder einem sonstigen Objekt (z.B. Datensatz).


### Numerische Variablen mit `favstats` untersuchen



Der einfachste Weg, um Deskriptivstatistik für eine *numerische Variable* auf einen Abwasch zu erledigen ist der Befehl `favstats` aus dem Paket `mosaic` (vorher laden nicht vergessen):


```r
favstats(mtcars$mpg)
#>   min     Q1 median   Q3  max     mean       sd  n missing
#>  10.4 15.425   19.2 22.8 33.9 20.09062 6.026948 32       0
```


Der Befehl `favstats` lässt auch Subgruppenanalysen zu, z.B. um Männer und Frauen zu vergleichen:


```r
favstats(mpg ~ cyl, data = mtcars)
#>   cyl  min    Q1 median    Q3  max     mean       sd  n missing
#> 1   4 21.4 22.80   26.0 30.40 33.9 26.66364 4.509828 11       0
#> 2   6 17.8 18.65   19.7 21.00 21.4 19.74286 1.453567  7       0
#> 3   8 10.4 14.40   15.2 16.25 19.2 15.10000 2.560048 14       0
```

Dabei ist `mpg` die Variable, die sie vergleichen wollen (Spritverbrauch); `cyl` die Gruppierungsvariable (Anzahl der Zylinder). Gruppierungsvariable bedeutet hier, dass den Spritverbrauch zwischen 4,6 und 8-Zylindern vergleichen wollen.


>   `favstats` ist sehr praktisch, weil Sie mit einem Befehl sehr viele Informationen bekommen, sogar Subgruppenanalysen sind möglich. Es lohnt sich für Sie, sich diesen Befehl gut zu merken.

💻 AUFGABE:

- Was sind wichtige Lagemaße für `hp``?
- Was sind wichtige Streuungsmaße für `mpg`?
- Welches Skalenniveau hat `am`? Für den Fall, dass `am` nicht metrisch ist (also kategorial), macht es dann Sinn, Mittelwert oder SD zu berechnen?


### Typische Deskriptive Statistiken

Die üblichen Verdächtigen der deskriptiven Statistiken lassen sich leiht aus Ihrem Versteck hervorlocken:


```r
mean(tip~sex, data=tips)
#>   Female     Male 
#> 2.833448 3.089618
median(tip~sex, data=tips)
#> Female   Male 
#>   2.75   3.00
sd(tip~sex, data=tips)
#>   Female     Male 
#> 1.159495 1.489102
var(tip~sex, data=tips)
#>   Female     Male 
#> 1.344428 2.217424
IQR(tip~sex, data=tips)
#> Female   Male 
#>   1.50   1.76
diffmean(tip~sex, data=tips)
#>  diffmean 
#> 0.2561696
min(tip~sex, data=tips)
#> Female   Male 
#>      1      1
max(tip~sex, data=tips)
#> Female   Male 
#>    6.5   10.0
```


⚠️ Alle diese Befehle sind etwas ... nervös. Fehlt in den entsprechenden untersuchten Tabellen nur ein Wert, so legen diese Befehle die Arbeit nieder. Die Begründung lautet, Sie sollen auf das Problem hingewiesen werden. Über diese Logik kann man streiten; möchten Sie die Befehle zum Arbeiten bringen, auch wenn einige Daten fehlen sollten, dann fügen Sie diesen Parameter hinzu: `na.rm = TRUE`.

Sinngemäß übersetzt: "Hey R, wenn Du NAs triffst (fehlende Werte), dann 'remove' (ignoriere) diese. Ja, genauso (TRUE) ist es!"


```r
mean(tip~sex, data=tips, na.rm = TRUE)
#>   Female     Male 
#> 2.833448 3.089618
```


### Korrelationen

Sagen wir, Sie möchten von diesen zwei Variablen `hp` und `mpg` die Korrelation berechnen:



```r
cor(hp ~ mpg, data = mtcars)
```

Falls Sie viele Variablen auf ihre Korrelation untersuchen wollen, können Sie es so auf einen Abwasch tun:


```r
tips2 <- select(tips, tip, total_bill, size)
cor(tips2)
#>                  tip total_bill      size
#> tip        1.0000000  0.6757341 0.4892988
#> total_bill 0.6757341  1.0000000 0.5983151
#> size       0.4892988  0.5983151 1.0000000
```


### Korrelationsplot


Mit Hilfe des Zusatzpakets `corrplot` lassen sich Korrelationen schön visualisieren. 


```r
#Zusatzpaket laden
library(corrplot)

corrplot(cor(tips2))
```

<img src="figure/unnamed-chunk-31-1.png" title="plot of chunk unnamed-chunk-31" alt="plot of chunk unnamed-chunk-31" width="70%" style="display: block; margin: auto;" />

Je intensiver die Farbe, desto höher die Korrelation. Hier gibt es unzählige Einstellmöglichkeiten, siehe `?corrplot` bzw. für Beispiele:


```r
vignette("corrplot-intro")

```

Noch einfacher, aber nicht so schön geht es mit dem Paket `corrgram`. Hier müssen nicht extra die metrischen Variablen ausgewählt werden. Er nimmt nur alle metrischen Variablen im Datensatz mit.  


```r
library(corrgram)
corrgram(tips2)
```

<img src="figure/unnamed-chunk-33-1.png" title="plot of chunk unnamed-chunk-33" alt="plot of chunk unnamed-chunk-33" width="70%" style="display: block; margin: auto;" />

Am schönsten, meiner Meinung nach, sieht es mit dem Paket `GGally` aus:


```r
library(GGally)
ggcorr(tips2)
ggpairs(tips2)
```

<img src="figure/unnamed-chunk-34-1.png" title="plot of chunk unnamed-chunk-34" alt="plot of chunk unnamed-chunk-34" width="70%" style="display: block; margin: auto;" /><img src="figure/unnamed-chunk-34-2.png" title="plot of chunk unnamed-chunk-34" alt="plot of chunk unnamed-chunk-34" width="70%" style="display: block; margin: auto;" />


### Nominale Variablen

Eine Häufigkeitstabelle für eine *nicht-metrische* Variable lässt über den Befehl `table` erstellen.

Mit dem Befehl `summary(meine_tabelle)` bekommt man schon eine brauchbare Übersicht für nominale (kategoriale) Variablen. Man kann aber auch den Befehl `table` verwenden, um sich Häufigkeit auszählen zu lassen:


```r
table(tips$sex)
#> 
#> Female   Male 
#>     87    157
```


## Zeilenmittelwerte bilden

Bei Umfragen kommt es häufig vor, dass man Zeilenmittelwerte bildet. Wieso? Man möchte z.B. in einer Mitarbeiterbefragung den "Engagementwert" jedes Beschäftigten wissen (klingt einfach gut). Dazu addiert man die Werte jedes passenden Items auf. Diese Summe teilen Sie durch die Anzahl der Spalten

💡 Zeilenmittelwerte bilden Sie am einfachsten in Excel.

In R können Sie Zeilen einfach mit dem `+` Zeichen addieren:

```
meine_tabelle$zeilenmittelwert <- (meine_tabelle$item1 + meine Tabelle$item2) / 2
```

## Zeilen filtern

Ist man daran interessiert, nur einen Teil der Fälle (=Zeilen) auszuwerten, so hilft der Befehl `filter` weiter; `filter` wird über das Paket `tidyverse` geladen.


```r
filter(tips, sex == "Male") -> tips_maenner
```

💻 AUFGABE:  

- Erstellen Sie eine Rauchertabelle (Datensatz `tips`)!
- Erstellen Sie eine Tabelle nur mit PS-starken Autos (der genaue Wert bleibt Ihnen überlassen; Datensatz `mtcars`).


## Spalten auswählen

Manchmal hat meine "breite" Tabelle, also viele Spalten. Da hilft Abspecken, um die Sachlage übersichtlicher zu machen. Sprich: Nur ein paar wichtige Spalten auswählen, die anderen unter den Tisch fallen lassen.

Das kann man mit dem Befehl `select` (engl. auswählen) erreichen, der über das Paket `tidyverse` geladen wird:


```r
select(tips, tip, total_bill) -> tips_schmal
```

Der Befehl kann noch ein paar Tricks, die man z.B. [hier](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/datenjudo.html#spalten-wahlen-mit-select) nachlesen kann.

💻 AUFGABE:  

- Erstellen Sie eine Tabelle nur mit `tip` und `total_bill`. Dann wenden Sie `rowSums` und `rowMeans` darauf an. Speichern Sie das Ergebnis von `rowSums` als neue Spalte von `tips`.




## Spalten einer Tabelle sortieren

Bestimmt haben Sie schon mal in Excel eine Spalte sortiert, z.B. so, dass die großen Eurowerte ganz oben standen. In R kann man das mit dem Befehl `arrange` (via `tidyverse`) erreichen:


```r
arrange(tips, -tip)
```


💻 AUFGABE:  

- Sortieren Sie `mtcars` nach Spritverbrauch!
- Sortieren Sie `mtcars` nach PS!
Sortieren Sie `mtcars` *gleichzeitig* nach Spritverbrauch und PS! (Tipp: `arrange(tabelle, spalte1, spalte2)`).

# Schritt 3: Visualisieren

Ein Bild sagt bekanntlich mehr als 1000 Worte. Betrachten Sie dazu "Anscombes Quartett":


<img src="https://sebastiansauer.github.io/images/2017-05-16/figure/anscombe.png" title="plot of chunk unnamed-chunk-40" alt="plot of chunk unnamed-chunk-40" width="50%" style="display: block; margin: auto;" />


Diese vier Datensätze sehen ganz unterschiedlich aus, nicht wahr? Aber ihre zentralen deskriptiven Statistiken sind praktisch gleich! Ohne Diagramm wäre uns diese Unterschiedlichkeit nicht (so leicht) aufgefallen!


Zur Visualisierung empfehle ich das R-Paket `ggforumla`. Hinter den Kulissen wir dem verbreiteten Visualiserungspaket `ggplot2` die Denkweise von `mosaic` eingeimpft. Der Hauptbefehl lautet `gf_XXX`, wobei `XXX` für eine bestimmte Art (Geom) von Diagramm steht, also z.B. ein Histogramm oder ein Boxplot.


## Syntax von `gf_XXX`

Die normale Denkweise von `mosaic` wird verwendet:

`gf_diagrammtyp(Y_Achse ~ X_Achse, sonstiges, data = meine_daten)`.

`gf_` steht für `ggplot` und `formula`. 


Darüber hinaus verkraftet der Befehl noch viele andere Schnörkel, die wir uns hier sparen. Interessierte können googeln... Es ist ein sehr mächtiger Befehl, der sehr ansprechende Diagramme erzeugen kann.

Probieren wir's!


```r
data(mtcars)
gf_point(mpg ~ hp, data = mtcars)
```

<img src="figure/unnamed-chunk-41-1.png" title="plot of chunk unnamed-chunk-41" alt="plot of chunk unnamed-chunk-41" width="70%" style="display: block; margin: auto;" />

Easy, oder?

Ein anderes Geom:


```r
gf_boxplot(mpg ~ factor(cyl), data = mtcars)
```

<img src="figure/unnamed-chunk-42-1.png" title="plot of chunk unnamed-chunk-42" alt="plot of chunk unnamed-chunk-42" width="70%" style="display: block; margin: auto;" />


:attention: Beachten Sie, dass  nur dann *mehrere Boxplots* gezeichnet werden, wenn auf der X-Achse eine nominal skalierte Variable steht.

💡 Eine metrische Variable wandeln Sie in eine nominal skalierte Variable um mit dem Befehl `factor(meine_metrische_variable)`.


Oder mal nur eine Variable (ihre Verteilung) malen:


```r
gf_histogram(~hp, data = mtcars)
```

<img src="figure/unnamed-chunk-43-1.png" title="plot of chunk unnamed-chunk-43" alt="plot of chunk unnamed-chunk-43" width="70%" style="display: block; margin: auto;" />

💡 Geben wir keine Y-Variable an, nimmt R eigenständig die Häufigkeit pro X-Wert!


## Jittern

Probieren Sie mal diesen Befehl:


```r
gf_point(hp ~ factor(cyl), data = mtcars)
```

<img src="figure/unnamed-chunk-44-1.png" title="plot of chunk unnamed-chunk-44" alt="plot of chunk unnamed-chunk-44" width="70%" style="display: block; margin: auto;" />

Sieht ganz ok aus. Aber was ist, wenn wir viele Punkte (=Fälle) haben? Schauen wir uns das im Datensatz `tips` an:


```r
gf_point(tip ~ sex, data = tips)
```

<img src="figure/unnamed-chunk-45-1.png" title="plot of chunk unnamed-chunk-45" alt="plot of chunk unnamed-chunk-45" width="70%" style="display: block; margin: auto;" />

Nicht so schön; viele Punkte überdecken sich gegenseitig. Dieses Überdecken bezeichnet man auch als "Overplotting" (hört sich cooler an). Besser wäre es, wenn sich die Punkte nicht überdecken würden, dann würde man besser erkennen, wie viele Puntke wo liegen. Eine einfache Lösung bestünde darin, das Bild etwas zu "schütteln" oder zu "wackeln", so dass die Punkte etwas verwackelt würden und damit nebeneinander zu liegen kämen. Das kann mit man mit dem Geom `jitter` (eng. für wackeln) erreichen:


```r
gf_jitter(tip ~ sex, data = tips)
```

<img src="figure/unnamed-chunk-46-1.png" title="plot of chunk unnamed-chunk-46" alt="plot of chunk unnamed-chunk-46" width="70%" style="display: block; margin: auto;" />

Möchte man die Punkte etwas enger haben, so kann man den Parameter `width` hinzufügen:


```r
gf_jitter(tip ~ sex, data = tips, width = .1)
```

<img src="figure/unnamed-chunk-47-1.png" title="plot of chunk unnamed-chunk-47" alt="plot of chunk unnamed-chunk-47" width="70%" style="display: block; margin: auto;" />


💡 Die Reihenfolge der Parameter in einem R-Befehl ist egal, solange man die Parameter benennt (width, data,...).


💻 AUFGABE:

- Tauschen Sie mal "histogram" mit "density"!
- Erstellen Sie ein Histogramm für `hp`! 
- Erstellen Sie Boxplots für `tip`, vergleichen Sie dabei Männer und Frauen (Tipp: `sex` steht auf der X-Achse).
- Erstellen Sie Boxplots für `hp`, vergleichen Sie dabei die verschiedenen Zylinder (Tipp: `cyl` muss noch in eine Faktorvariable umgewandelt werden).



## Plot, um Mittelwerte darzustellen

Möchte man nur zwei Mittelwerte darstellen, ist ein Diagramm überflüssig, streng genommen. Schöner ist es, mehr Informationen darzustellen, also z.B. die Rohdaten. Schauen wir uns ein Beispiel aus dem Datensatz `tips` an:


```r
gf_point(hp ~ factor(cyl),
         data = mtcars,
         stat = "summary",
         color = "red", 
         size = 5)
```

<img src="figure/unnamed-chunk-48-1.png" title="plot of chunk unnamed-chunk-48" alt="plot of chunk unnamed-chunk-48" width="70%" style="display: block; margin: auto;" />

Überprüfen wir mal, ob die Punkte beim Mittelwert liegen:


```r
mean(hp ~ cyl, data = mtcars)
#>         4         6         8 
#>  82.63636 122.28571 209.21429
```

😄.

Am besten, wir kombinieren die Rohdaten mit den Mittelerten in einem Plot:



```r
gf_point(hp ~ factor(cyl),
         data = mtcars) %>% 
gf_point(hp ~ factor(cyl),
         data = mtcars,
         stat = "summary",
         color = "red", size = 5)
```

<img src="figure/unnamed-chunk-50-1.png" title="plot of chunk unnamed-chunk-50" alt="plot of chunk unnamed-chunk-50" width="70%" style="display: block; margin: auto;" />

Was bedeutet das komische Symbol `%>%`, welches die beiden Befehle offenbar verkettet? Man nennt es "DIE PFEIFE" (Großbuchstaben machen es erst richtig bedeutsam). Und auf Deutsch heißt dieser Befehl in etwa "UND DANN MACHE...". Hier verketter die Pfeife die Beiden Diagrammbefehle, so dass beide Diagramme übereinander gezeichent werden - ähnlich wie eine Klarsichtfolie, die über ein Bild gelegt wird.

Der Parameter `stat = summary` führt dazu, dass als Punkte nicht die Rohdaten, sondern eben eine Zusammenfassung (engl. summary) dargestellt wird. In der Voreinstellung ist das der Mittelwert.


## Weitere Geome
[Hier](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/daten-visualisieren.html#geome) finden Sie einen Überblick zu Geomen von ggplot, z.B.:

- Boxplot
- Punkte
- Linien
- Histogramm
- Fliesen 
- ...



🔖 Lesen Sie hier weiter, um Ihr Wissen zu vertiefen zu diesem Thema: [Vertiefung zur Datenvisualisierung](https://cran.r-project.org/web/packages/ggformula/vignettes/ggformula.html)


# Schritt 4: Modellieren

Modellieren hört sich kompliziert an. Für uns hier heißt es vor allem ein inferenzstatistisches Verfahren anzuwenden.


## Der p-Wert

Ach ja, der p-Wert. Generationen von ~~Dozenten~~Studierenden haben sich wegen ihm oder ob ihm die Haare gerauft. Was war noch mal die Definition des p-Werts? Oder einfacher vielleicht, was will uns der p-Wert sagen:

🔖 Lesen Sie hier weiter, um Ihr Wissen zu vertiefen zu diesem Thema: [Vertiefung zum p-Wert](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/der-p-wert-inferenzstatistik-und-alternativen.html#der-p-wert-sagt-nicht-das-was-viele-denken


## Die Regression als Schweizer Taschenmesser
💡 Das Schweizer Taschenmesser 🔪 und den Modellierungsverfahren ist die Regressionsanalyse. Man kann sie für viele Zwecke einsetzen.

## Wann welchen Test?

Es gibt in vielen Lehrbüchern Übersichten zur Frage, wann man welchen Test rechnen soll. Googeln hilft hier auch weiter. Eine Übersicht findet man [hier](http://www.methodenberatung.uzh.ch/de/datenanalyse.html) oder [hier](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/der-p-wert-inferenzstatistik-und-alternativen.html#wannwelcher).

## Wie heißt der jeweilige R-Befehl?

Wenn man diese Befehle nicht häufig verwendet, ist es schwierig, sie auswendig zu wissen. Googeln Sie. Eine gute Übersicht findet sich hier: <http://r-statistics.co/Statistical-Tests-in-R.html>.


## Regression

Weil die Regression so praktisch ist, hier ein Beispiel.


```r
lm(mpg ~ cyl, data = mtcars)
#> 
#> Call:
#> lm(formula = mpg ~ cyl, data = mtcars)
#> 
#> Coefficients:
#> (Intercept)          cyl  
#>      37.885       -2.876
```

`lm` heißt "lineares Modell" - weil man bei der (normalen) Regression eine Gerade in die Punktewolke der Daten legt, um den Trend zu abzuschätzen. Als nächstes gibt man die "Ziel-Variable" (Output) an, hier `mpg`. Dann kommt ein Kringel `~` gefolgt von einer (mehr) Input-Variablen (Prädiktoren, UVs). Schließlich muss noch die Datentabelle erwähnt werden. 

Das Ergebnis sagt uns, dass *pro Zylinder* die Variable `mpg` um knapp 3 Punkte sinkt. Also: Hat die Karre einen Zylinder mehr, so kann man pro Galone Sprit 3 Meilen weniger fahren. Immer im Schnitt, versteht sich. (Und wenn die Voraussetzungen erfüllt sind, aber darum kümmern wir uns jetzt nicht.)


Allgemein:

```
lm(output ~ input, data = meine_daten)
```

Easy, oder?

Man kann auch mehrere Prädiktoren anführen:


```r
lm(mpg ~ cyl + hp, data = mtcars)
#> 
#> Call:
#> lm(formula = mpg ~ cyl + hp, data = mtcars)
#> 
#> Coefficients:
#> (Intercept)          cyl           hp  
#>    36.90833     -2.26469     -0.01912
```

Dazu werden die durch `+` getrennt. Die Ergebnisse zeigen uns, dass die PS-Zahl (´hp´) kaum Einfluss auf den Spritverbrauch haut. Genauer: Kaum *zusätzlichen* Einfluss auf den Spritverbrauch hat. Also Einfluss, der über den Einfluss hinausgeht, der schon durch die Anzahl der Zylinder erklärt werden würde. Es ist also praktisch wurscht, wie viel PS das Auto hat, wenn man den Verbrauch schätzen will - Hauptsache, man weiß die Anzahl der Zylinder.

### Vorhersagen

Man kann die Regression nutzen, um Vorhersagen zu treffen. Sagen wir, unser neuer Lamborghini hat 400 PS und 12 Zylinder. Wie groß ist wohl der Spritverbrauch laut unserem Regressionsmodell?

Als Vorbereitung speichern wir unser Regressionsmodell in einer eigenen Variablen:


```r
mein_lm <- lm(mpg ~ cyl + hp, data = mtcars)
```


Dazu nimmt man am besten den Befehl `predict`, weil wir wollen eine Vorhersage treffen:


```r
predict(mein_lm, data.frame(cyl = 12, hp = 400))
#>        1 
#> 2.083329
```

Aha. Pro Gallone kämmen wir 2 Meilen. Schluckspecht.


## Häufige Verfahren der Inferenzstatistik


### $\chi^{2}$-Test
Der $\chi^{2}$-Test (sprich: Chi-Quadrat-Test) wird verwendet, um auf Unabhängigkeit zweier Mermale bzw. auf Homogenität der (Häufigkeits-)Verteilungen zweier kategorieller, i.d.R. nominal skalierter Merkmale zu prüfen. Die zugehörige Nullhypothese lautet \emph{$H_{0}:$ Die beiden Merkmale sind unabhängig.}  

__Beispiel (Trinkgeld-Datensatz)__  
Es ist zu prüfen: \emph{$H_{0}:$ Das Rauchverhalten ist vom Geschlecht unabhängig.}  


```r
xchisq.test(tally(sex~smoker, data=tips))
#> 
#> 	Pearson's Chi-squared test with Yates' continuity correction
#> 
#> data:  x
#> X-squared = 0, df = 1, p-value = 1
#> 
#>    54       33   
#> (53.84)  (33.16) 
#> [0.00047] [0.00077]
#> < 0.022> <-0.028>
#>    
#>    97       60   
#> (97.16)  (59.84) 
#> [0.00026] [0.00043]
#> <-0.016> < 0.021>
#>    
#> key:
#> 	observed
#> 	(expected)
#> 	[contribution to X-squared]
#> 	<Pearson residual>
```

Zusammenhangsmaße wie den Kontingenzkoeffizienten oder Cramérs V erhält man mit nachfolgendem Befehl (das Paket \texttt{vcd} muss aktiviert sein):


```r
library(vcd)
assocstats(tally(sex~smoker, data=tips))
#>                        X^2 df P(> X^2)
#> Likelihood Ratio 0.0019354  1  0.96491
#> Pearson          0.0019348  1  0.96492
#> 
#> Phi-Coefficient   : 0.003 
#> Contingency Coeff.: 0.003 
#> Cramer's V        : 0.003
```

💻 AUFGABE: 

Testen Sie die Nullhypothese \emph{$H_{0}:$ Der Essenstag ist vom Geschlecht des Rechnungsbezahlers unabhängig} und bestimmen Sie die Stärke des Zusammenhangs mit dem Kontingenzkoeffizienten.  

### t-Test
Der t-Test wird verwendet, um Mittelwerte metrisch skalierter Merkmale zu prüfen. Dabei kann entweder der Mittelwert einer Messreihe mit einem vorgegebenen Wert verglichen werden (Beispiel-\emph{$H_{0}:$ Das Alter aller FOM-Studierenden ist im Durchschnitt 25 Jahre}), oder die Mittelwerte zweier Messreihen werden miteinander verglichen (Beispiel-\emph{$H_{0}:$ Studentinnen und Studenten an der FOM sind im Durchschnitt gleich alt}). Im Falle zweier Stichproben wird zwischen abhängigen und unabhängigen Stichproben unterschieden.  

Zwei Stichproben sind unabhängig, wenn an verschiedenen Subjekten das gleiche Merkmal erhoben wird. Beispiel: Alter (gleiches Merkmal) bei Studentinnen und Studenten (verschiedene Subjekte).  

Zwei Stichproben sind abhängig, wenn verschiedene Merkmale an den gleichen Subjekten erhoben werden. Beispiel: Blutdruck vor und nach einer Behandlung (verschiedene Merkmale) an einer Gruppe von Patienten (gleiche Subjekte).  

Ein t-Test kann mit einseitiger und zweiseitiger Nullhypothese durchgeführt werden. Bei einer zweiseitigen Nullhypothese wird auf Gleichheit getestet (Beispiel-\emph{$H_{0}: \mu=0$}), die Nullhypothese wird bei starker Abweichung nach oben und unten verworfen. Bei einer einseitigen Nullhypothese wird auf kleinergleich oder größergleich getestet (Beispiel-\emph{$H_{0}: \mu \le 0$} oder \emph{$H_{0}: \mu \ge 0$}), die Nullhypothese wird bei starker Abweichung nach oben oder unten verworfen.

#### Einstichproben-t-Test
__Beispiel (Trinkgeld-Datensatz)__  
Es ist zu prüfen \emph{$H_{0}:$ Es wird kein Trinkgeld gegeben ($H_{0}: \mu(tip) = 0$)}. Zunächst sollte mit einer grafischen Darstellung und deskriptiven Statistiken begonnen werden.

```r
gf_dens(~tip, data=tips)
gf_boxplot(tip~"alle", data = tips)
favstats(~tip, data=tips)
#>  min Q1 median     Q3 max     mean       sd   n missing
#>    1  2    2.9 3.5625  10 2.998279 1.383638 244       0
```

<img src="figure/unnamed-chunk-57-1.png" title="plot of chunk unnamed-chunk-57" alt="plot of chunk unnamed-chunk-57" width="70%" style="display: block; margin: auto;" /><img src="figure/unnamed-chunk-57-2.png" title="plot of chunk unnamed-chunk-57" alt="plot of chunk unnamed-chunk-57" width="70%" style="display: block; margin: auto;" />

Nun kommt der t-Test.


```r
t.test(~tip, data=tips)
#> ~tip
#> 
#> 	One Sample t-test
#> 
#> data:  tip
#> t = 33.849, df = 243, p-value < 2.2e-16
#> alternative hypothesis: true mean is not equal to 0
#> 95 percent confidence interval:
#>  2.823799 3.172758
#> sample estimates:
#> mean of x 
#>  2.998279
```

Im Output finden sich zunächst der t-Wert (durchschnittliches Trinkgeld dividiert durch den Standardfehler), die Freiheitsgrade (Stichprobenumfang weniger 1) und der p-Wert (Wahrscheinlichkeit für t unter der Nullhypothese). Weiter finden sich ein 95%-Konfidenzintervall für die Trinkgeldhöhe sowie das durchschnittliche Trinkgeld.  

Die Funktion \texttt{t.test} führt immer einen zweiseitigen Test durch. Soll ein einseitiger Test durchgeführt werden, so muss dies durch einen zusätzlichen Übergabeparameter kenntlich gemacht werden. Um von diesem die genaue Syntax zu erfahren kann die R-Hilfe zur Funktion aufgerufen werden.

```r
?t.test
```

__Beispiel (Trinkgeld-Datensatz)__  
Es ist zu prüfen \emph{$H_{0}:$ Es wird mindestens 0 Dollar Trinkgeld gegeben ($H_{0}: \mu(tip) \ge 0$)}
Laut der Beschreibung der Funktionshilfe erwartet R die Sepzifikation der Alternativhypothese. Der zugehörige Übergabeparameter lautet \texttt{alternative=\dq less\dq} und damit lautet der R-Befehl:

```r
t.test(~tip, data=tips, alternative="less")
#> ~tip
#> 
#> 	One Sample t-test
#> 
#> data:  tip
#> t = 33.849, df = 243, p-value = 1
#> alternative hypothesis: true mean is less than 0
#> 95 percent confidence interval:
#>      -Inf 3.144535
#> sample estimates:
#> mean of x 
#>  2.998279
```

💻 AUFGABE: 

1. Testen Sie die Nullhypothese \emph{$H_{0}:$ Es wird höchstens zwei Dollar Trinkgeld gegeben ($H_{0}: \mu(tip) \le 2$)}.  
2. Bestimmen Sie ein 90%-Konfidenzintervall für das durchschnittliche Trinkgeld.  

#### Zweistichproben-t-Test  
__Beispiel (Trinkgeld-Datensatz)__  
Es ist zu prüfen \emph{$H_{0}:$ Männer und Frauen geben gleich viel Trinkgeld ($H_{0}: \mu(tip_{Männer})-\mu(tip_{Frauen})= 0$)}. Es empfiehlt sich, zunächst mit einer grafischen Darstellung sowie deskriptiven Statistiken zu starten. Als grafische Darstellungen bieten sich Boxplots und Mittelwertplots an.

```r
gf_boxplot(tip~sex, data=tips) # Boxplot
gf_point(tip~sex, data=tips, stat = "summary") # Mittelwertplot
favstats(tip~sex, data=tips) # deskriptive Statistiken
#>      sex min Q1 median   Q3  max     mean       sd   n missing
#> 1 Female   1  2   2.75 3.50  6.5 2.833448 1.159495  87       0
#> 2   Male   1  2   3.00 3.76 10.0 3.089618 1.489102 157       0
```

<img src="figure/unnamed-chunk-61-1.png" title="plot of chunk unnamed-chunk-61" alt="plot of chunk unnamed-chunk-61" width="70%" style="display: block; margin: auto;" /><img src="figure/unnamed-chunk-61-2.png" title="plot of chunk unnamed-chunk-61" alt="plot of chunk unnamed-chunk-61" width="70%" style="display: block; margin: auto;" />

Nun kann der t-Test durchgeführt werden.


```r
t.test(tip~sex, data=tips)
#> tip ~ sex
#> 
#> 	Welch Two Sample t-test
#> 
#> data:  tip by sex
#> t = -1.4895, df = 215.71, p-value = 0.1378
#> alternative hypothesis: true difference in means is not equal to 0
#> 95 percent confidence interval:
#>  -0.5951448  0.0828057
#> sample estimates:
#> mean in group Female   mean in group Male 
#>             2.833448             3.089618
```

💻 AUFGABE: 

Testen Sie die Nullhypothese \emph{$H_{0}:$ Das durchschnittliche Trinkgeld ist genauso hoch wie die durchschnittliche Restaurantrechnung ($H_{0}: \mu(tip) = \mu(totalbill)$)}.  

# Varianzanalyse
Sollen mehr als zwei Mittelwerte miteinander verglichen werden, dann muss anstelle eines t-Tests eine Varianzanalyse durchgeführt werden.

Mit einer Varianzanalyse ist es möglich, sowohl mehr als zwei Mittelwerte miteinander zu vergleichen (einfaktorielle Varianzanalyse) als auch mehr als eine Gruppierungsvariable (mehrfaktorielle Varianzanalyse) zu prüfen. Allgemeiner formuliert prüft die Varianzanalyse, ob ein metrisch skaliertes Merkmal (Zielgröße) von einer oder mehreren kategoriellen Gruppierungsvariablen (Einflussgrößen bzw. Faktoren) abhängt. Dabei lassen sich zum einen für jeden Faktor getrennt die Einflüsse untersuchen (Haupteffekte) als auch die Einflüsse kombinierter Effekte (Wechselwirkungen).  

## Einfaktorielle Varianzanalyse
__Beispiel (Trinkgeld-Datensatz)__  
Es ist zu prüfen \emph{$H_{0}:$ Die durchschnittlichen Restaurantrechnungen sind an den vier verschiedenen Tagen (Donnerstag bis Sonntag) gleich hoch.} Zunächst werden Grafiken und deskriptive Statistiken erstellt.

```r
gf_boxplot(total_bill~day, data=tips) %>% 
gf_point(total_bill~day, data=tips, stat = "summary", color = "red") # Mittelwertplot
favstats(total_bill~day, data=tips) # deskriptive Statistiken
#>    day  min      Q1 median      Q3   max     mean       sd  n missing
#> 1  Fri 5.75 12.0950  15.38 21.7500 40.17 17.15158 8.302660 19       0
#> 2  Sat 3.07 13.9050  18.24 24.7400 50.81 20.44138 9.480419 87       0
#> 3  Sun 7.25 14.9875  19.63 25.5975 48.17 21.41000 8.832122 76       0
#> 4 Thur 7.51 12.4425  16.20 20.1550 43.11 17.68274 7.886170 62       0
```

<img src="figure/unnamed-chunk-63-1.png" title="plot of chunk unnamed-chunk-63" alt="plot of chunk unnamed-chunk-63" width="70%" style="display: block; margin: auto;" />

Dann folgt die Varianzanalyse:

```r
anovamodel <- aov(total_bill~day, data=tips)
summary(anovamodel)
#>              Df Sum Sq Mean Sq F value Pr(>F)  
#> day           3    644  214.65   2.767 0.0425 *
#> Residuals   240  18615   77.56                 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


## Mehrfaktorielle Varianzanalyse
Bei mehrfaktoriellen Varianzanalysen können sowohl die Haupteffekte als auch die Wechselwirkungen zwischen den Haupteffekten untersucht werden.  



__Beispiel (Trinkgeld-Datensatz)__  
Folgende drei Hypothesen sind zu prüfen:  
\emph{$H_{01}:$ Das Geschlecht des Rechnungsbezahlers hat keinen Einfluss auf die Rechnungshöhe.}  
\emph{$H_{02}:$ Das Rauchverhalten des Rechnungsbezahlers hat keinen Einfluss auf die Rechnungshöhe.}  
\emph{$H_{03}:$ Das gibt keine Wechselwirkung zwischen Geschlecht und Rauchverhalten des Rechnungsbezahlers.}  


```r
anovamodel <- aov(total_bill~sex*smoker, data=tips)
summary(anovamodel)
#>              Df Sum Sq Mean Sq F value Pr(>F)  
#> sex           1    404   404.2   5.209 0.0233 *
#> smoker        1    140   140.2   1.806 0.1802  
#> sex:smoker    1     91    90.6   1.168 0.2810  
#> Residuals   240  18623    77.6                 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
plot(allEffects(anovamodel))
```

<img src="figure/unnamed-chunk-66-1.png" title="plot of chunk unnamed-chunk-66" alt="plot of chunk unnamed-chunk-66" width="70%" style="display: block; margin: auto;" />

Ein Modell nur für die Haupteffekte funktioniert wie folgt:


```r
anovamodel <- aov(total_bill~sex+smoker, data=tips)
summary(anovamodel)
#>              Df Sum Sq Mean Sq F value Pr(>F)  
#> sex           1    404   404.2   5.206 0.0234 *
#> smoker        1    140   140.2   1.805 0.1804  
#> Residuals   241  18714    77.7                 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
plot(allEffects(anovamodel))
```

<img src="figure/unnamed-chunk-67-1.png" title="plot of chunk unnamed-chunk-67" alt="plot of chunk unnamed-chunk-67" width="70%" style="display: block; margin: auto;" />

Es folgt das Modell nur für die Wechselwirkungen:

```r
anovamodel <- aov(total_bill~sex:smoker, data=tips)
summary(anovamodel)
#>              Df Sum Sq Mean Sq F value Pr(>F)  
#> sex:smoker    3    635   211.7   2.728 0.0447 *
#> Residuals   240  18623    77.6                 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
plot(allEffects(anovamodel))
```

<img src="figure/unnamed-chunk-68-1.png" title="plot of chunk unnamed-chunk-68" alt="plot of chunk unnamed-chunk-68" width="70%" style="display: block; margin: auto;" />

💻 AUFGABE: 
  
Führen Sie eine zweifaktorielle Varianzanalyse für die Zielgröße \texttt{tips} mit den Faktoren \texttt{time} und \texttt{smoker} durch.


# Korrelationsanalyse
Die Korrelationsanalyse wird verwendet, um den Zusammenhang von mindestens zwei metrischen oder ordinalen Merkmalen zu beschreiben. Für ordinale Merkmale wird die Spearman-Rangkorrelation verwendet. Da diese auf den Rängen der Ausprägungen basiert, ist sie robust gegen Ausreißer. Für metrische Merkmale wird die Pearson-Korrelation bestimmt, diese ist anfällig gegen Ausreißer. Hier empfiehlt sich zusätzlich die grafische Darstellung mit einem Streudiagramm.  

Hinweis: Eine (positive oder negative) Korrelation zwischen zwei Merkmalen bedeutet nicht, dass es auch einen Kausalzusammenhang gibt. Das bekannteste Beispiel hierfür ist die sog. Theorie der Störche. So lässt sich zeigen, dass es eine positive Korrelation zwischen Geburtenraten und Storchpopulationen gibt. Ein Kausalzusammenhang darf bezweifelt werden...  

__Beispiel (Trinkgeld-Datensatz)__  
Es ist der Zusammenhang zwischen der Höhe der Restaurantrechnung und der Trinkgeldhöhe zu untersuchen. 

```r
gf_point(tip~total_bill, data=tips)
```

<img src="figure/unnamed-chunk-69-1.png" title="plot of chunk unnamed-chunk-69" alt="plot of chunk unnamed-chunk-69" width="70%" style="display: block; margin: auto;" />

Die aufwärts gerichtete Punktwolke deutet auf eine positive Korrelation hin. Die Stärke der Korrelation ergibt sich wie folgt:

```r
cor <- aggregatingFunction2(stats::cor)
cor(tip ~ total_bill, data=tips) # Pearson-Korrelation
#> [1] 0.6757341
cor(tip ~ total_bill, data=tips, method="spearman") # Spearman-Korrelation
#> [1] 0.6789681
```




# Schritt 5: Kommunizieren

Kommunizieren soll sagen, dass Sie Ihre Ergebnisse anderen mitteilen - als Student heißt das häufig in Form einer Seminararbeit an den Dozenten. 

Einige Hinweise:

- Geben Sie nicht alle Ergebnisse heraus. Ihre Fehler müssen niemanden interessieren.
- Die wesentlichen Ergebnisse kommen in den Hauptteil der Arbeit. Interessante Details in den Anhang.
- Der Mensch ist ein Augentier. Ihr Gutachter auch. Achten Sie auf optisch ansprechende Darstellung; schöne Diagramme helfen.
- Dozenten achten gerne auf formale Korrektheit. Das Gute ist, dass dies relativ einfach sicherzustellen ist, da auf starren Regeln basierend.


## Tabellen und Diagramme

Daten kommunizieren heißt praktisch zumeist, Tabellen oder Diagramme zu erstellen. Meist gibt es dazu Richtlinien von Seiten irgendeiner (selbsternannten) Autorität wie Dozenten oder Fachgesellschaften. Zum Beispiel hat die [APA](http://www.apa.org) ein umfangreiches Manual zum Thema Manuskriptgestaltung publiziert; die deutsche Fachgesellschaft der Psychologie entsprechend. Googeln Sie mal, wie in ihren Richtlinien Tabellen und Diagramme zu erstellen sind (oder fragen Sie Ihren Gutachter).


## Für Fortgeschrittene: RMarkdown

Wäre das nicht cool: Jegliches Formatieren wird automatisch übernommen und sogar so, das es schick aussieht? Außerdem wird Ihr R-Code und dessen Ergebnisse (Tabellen und Diagramme oder reine Zahlen) automatisch in Ihr Dokument übernommen. Keine Copy-Paste-Fehler mehr. Keine händisches Aktualisieren, weil Sie Daten oder die vorhergehende Analyse geändert haben. Hört sich gut an? Probieren Sie mal [RMarkdown](http://rmarkdown.rstudio.com) aus 👍.



# Literaturempfehlung für den Einstieg in R mit dem Paket mosaic

- Daniel T. Kaplan, Nicholas J. Horton, Randall Pruim,  (2013): Project MOSAIC Little Books *Start Teaching with R*,  [http://mosaic-web.org/go/Master-Starting.pdf](http://mosaic-web.org/go/Master-Starting.pdf)




# Versionshinweise
* Datum erstellt: 2017-09-14
* R Version: 3.4.0
* `mosaic` Version: 1.1.0
* `dplyr` Version: 0.7.3
