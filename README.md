# Dockerized open GIS data in PostGIS

## Wat is dit?
Vanuit onze dagelijkse werkzaamheden komt het nogal eens voor dat we een kant-en-klare database nodig hebben van de BAG, BRT of van de BGT. Het inladen van deze data is alleen nogal eens ingewikkeld, tijdrovend en er blijft altijd een hoop rommel achter op het moment dat de klus geklaard is: een grote database gevuld met één of meer grote datasets die veel ruimte en geheugen in beslag neemt. Idealiter is het werken met grote geodatasets snel, volautomatisch en eenvoudig op te ruimen. [Docker](https://docs.docker.com/) biedt hiertoe de ideale oplossing.

Deze code repository bevat een 'fire and forget' benadering voor het volledig automatisch inladen van populaire geodatasets om snel mee aan de slag te gaan. Benodigdheden: een installatie van 
- [Docker](https://docs.docker.com/install/#supported-platforms) en 
- [Docker-compose](https://docs.docker.com/compose/install/)

De geodata wordt in **dezelfde** database opgeslagen, in verschillende database schema's. Dit maakt dat je (ruimtelijke) vragen kan stellen over verschillende datasets en eenvoudig aan data-integratie kan doen! 

# Hoe werkt het?
Je kan datasets zoals de BAG en de BRT automatisch inladen. Je moet alleen wel in de docker compose configuratie (in `docker-compose.yml`) aangeven welke datasets je wil. Kies bijvoorbeeld:
```yaml
environment:
  - GEODATASETS=bag,brt 
```

Bij het starten van de database met 
```bash
docker-compose up
```
zullen nu de BAG en de BRT automatisch worden ingeladen. Je kan daarna met PGadmin de database benaderen op standaard poort 5432. Als je al een database hebt draaien op die poort kan je eenvoudig de doelpoort aanpassen in de docker compose configuratie `docker-compose.yml`

# FAQ
## Welke datasets kan ik gebruiken?
- De [Basisregistratie Adressen en Gebouwen (BAG)](https://bag.basisregistraties.overheid.nl/)
- De [Basisregistratie Topografie (BRT)](https://www.kadaster.nl/brt)

## Mijn database draait al, maar ik wil toch nog een dataset toevoegen
Dat kan, heel eenvoudig. Wil je bijvoorbeeld de BRT toevoegen, voer dan de volgende opdracht uit:
`docker-compose exec geodata datasets/brt.sh`
Je kan op dezelfde manier ook zelf scripts toevoegen die data inladen. Als het open datasets zijn, dan horen we graag welk script je hebt gebruikt om je data te laden, zodat we dit met anderen kunnen delen, dan voegen we je script toe aan de collectie!  

## De klus is geklaard, hoe ruim ik de boel weer op?
Hiervoor voer de volgende opdrachten uit:
```bash
docker-compose stop
docker-compose rm geodata
rm -rf ./geodata/database
```

## Ik krijg de melding `pg_restore: [archiver] unsupported version (1.13) in file header`
Dit betekent dat het postgresql image voor de PostGIS database achterloopt. Werk de versie van je image en container bij:
```bash
docker-compose stop geodata
docker-compose rm geodata
docker pull mdillon/postgis:9.6
docker-compose build
docker-compose up 
```

Mocht hier een updgrade van de PostGIS extensie mee gepaard gaan, dan moet de template ook even weten dat PostGIs is geupgrade:
```bash
docker-compose exec geodata psql -d geodata -U postgres -c "SELECT postgis_full_version();"
```
Dit zal je de PostGIS versie weergeven. Het antwoord zal beginnen met iets als ` POSTGIS="2.5.0 r16836"` 
Vooral het versienummer is hier van belang, update de database nu met:
```bash
docker-compose exec geodata psql -d geodata -U postgres -c 'alter extension postgis update to "2.5.0";'

```

### TODO:
- De [Basisregistratie Grootschalige Topografie (BGT)](https://www.kadaster.nl/bgt)
- De [Basisregistratie Topografie (BRT)](https://www.kadaster.nl/brt)

