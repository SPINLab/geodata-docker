# Dockerized open GIS data in PostGIS

## Wat is dit?
Vanuit onze dagelijkse werkzaamheden komt het nogal eens voor dat we een kant-en-klare database nodig hebben van de BAG of van de BGT. Het inladen van deze data is alleen nogal eens ingewikkeld, tijdrovend en er blijft altijd een hoop rommel achter op het moment dat de klus geklaard is: een grote database gevuld met één of meer grote datasets die veel ruimte en geheugen in beslag neemt. Idealiter is het werken met grote geodatasets snel, volautomatisch en eenvoudig op te ruimen. [Docker](https://docs.docker.com/) biedt hiertoe de ideale oplossing.

Deze code repository bevat een 'fire and forget' benadering voor het volledig automatisch inladen van populaire geodatasets om snel mee aan de slag te gaan. Benodigdheden: een installatie van 
- [Docker](https://docs.docker.com/install/#supported-platforms) en 
- [Docker-compose](https://docs.docker.com/compose/install/)

De geodata wordt in **dezelfde** database opgeslagen, in verschillende database schema's. Dit maakt dat je (ruimtelijke) vragen kan stellen over verschillende datasets en eenvoudig aan data-integratie kan doen! 

## Welke datasets kan ik gebruiken?
- De [Basisregistratie Adressen en Gebouwen (BAG)](https://bag.basisregistraties.overheid.nl/)

### TODO:
- De [Basisregistratie Grootschalige Topografie (BGT)](https://www.kadaster.nl/bgt)
- De [Basisregistratie Topografie (BRT)](https://www.kadaster.nl/brt)
