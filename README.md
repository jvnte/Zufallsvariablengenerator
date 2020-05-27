## Build docker file

```shell
docker build -t my-shinyapp-image . 
```



## Run docker file

```shell
docker run -d --rm -p 3838:3838 my-shinyapp-image
```

