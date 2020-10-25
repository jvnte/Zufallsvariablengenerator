## Welcome to Zufallsvariablengenerator	

A R Shiny application that allows you to generate and visualise common discrete and continuous random variables. 

### Run App locally in Docker container

To run the app in an isolated environment install docker [here](https://docs.docker.com/get-docker/). Then navigate to project root directory and build the container image by executing the following in you CLI:

```shell
docker build -t my-shinyapp-image . 
```

This might take a couple of minutes. After the image is build start the container by running:

```shell
docker run -d --name my-shiny-app -p 3838:3838 my-shinyapp-image
```

Open a browser and enter [localhost:3838](localhost:3838) to access the app.

### Stop the App

To stop the container enter:

```shell
docker stop my-shiny-app
```

If you want to delete the container execute:

```shell
docker rm my-shiny-app -f
```



