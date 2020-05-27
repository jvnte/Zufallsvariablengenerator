Build docker file command:

docker build -t my-shinyapp-image . 

Run docker file:

docker run -d --rm -p 3838:3838 my-shinyapp-image
