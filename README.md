## Install Docker

Find installation links for Docker [here](https://docs.docker.com/get-docker/)!

## Build Docker file

```shell
docker build -t my-shinyapp-image . 
```


## Run Docker file

```shell
docker run -d --rm -p 3838:3838 my-shinyapp-image
```

