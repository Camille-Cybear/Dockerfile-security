# Dockerfile-security

## Les mesures de sécurité :

- User : nginx sans privilèges
- Port exposé 8080
- Limites de mémoire 128m
- Limites de cpus : 0.5
- Limites de processus : 50
- Activation des services nécéssaires uniquement avec cap-drop ALL

### Le script

Voici le launcher du container :

```bash
#!/bin/bash

docker run -d \
--memory="128m" \
--cpus="0.5" \
--pids-limit=50 \
--cap-drop ALL \
-p 8080:8080 \
    dockerfile-security
```

### Le dockerfile

Il contient :

```bash
# On appelle une image nginx sans privileges : nativement non-root, changement du port d'exposition
FROM nginxinc/nginx-unprivileged:1.30-alpine3.23
#Passage temporaire en root pour lancer les MAJ
USER root
#Lancement des MAJ
RUN apk update && apk upgrade
#Passage en utilisateur nginx non-root
USER nginx
#Copie de la page web
COPY index.html /usr/share/nginx/html/
#Signalement du ort d'exposition passant à 8080 au lieu de 80
EXPOSE 8080
```
### La page web index contient seulement un titre en H1

```html
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="___">
    <title>___</title>
</head>

<body>
    <h1>Ceci est une page web !</h1>
</body>

</html>
```
