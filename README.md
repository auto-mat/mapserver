# K8 Mapserver Docker image

### Build Docker Mapserver image and run container

```bash
# Build Docker image
docker buildx build .

# Run Docker Mapserver container
docker run -it --rm \
--publish=8000:80 \
--name=mapserver \
<YOUR_BUILDED_DOCKER_IMAGE_ID> OR auto0mat/mapserver:0

# Render WMS service file base_maps.map Mimovegetacni_letecke_snimkovani layer image
test@test:~$ curl "http://localhost:8001/mapserv\
?map=/opt/mapserver/base_maps.map\
&SERVICE=WMS\
&REQUEST=Getmap\
&VERSION=1.1.1\
&LAYERS=Mimovegetacni_letecke_snimkovani\
&SRS=EPSG:3857\
&BBOX=1580784.029757,6431299.916350,1640176.934719,6478860.648344\
&FORMAT=PNG\
&WIDTH=800\
&HEIGHT=600\
&STYLES=" \
--output mimovegetacni_letecke_snimkovani.png

# Check rendered WMS service Mimovegetacni_letecke_snimkovani layer image
test@test:~$ xdg-open mimovegetacni_letecke_snimkovani.png
```

### Licence

[GNU AGPLv3](https://www.gnu.org/licenses/agpl-3.0.en.html) or later.
