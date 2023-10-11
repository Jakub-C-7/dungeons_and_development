# Dungeons and Development

A unique twist on personal development.

## Running with Docker

The application is ready to run in a containerised environment with the use of docker.

### Creating docker image

If you already have the container ready to run, skip to the 'Running the docker container' section

1. Navigate to the project's root directory ('/dungeons_and_development') in a terminal of your choice.
2. Run the folowing command to create the docker image `docker build --tag dungeons_and_development .`
3. Run the folowing command to list all available images `docker images`, and confirm that an image with the name 'dungeons_and_development' is present
4. Your image has been built!

### Running the docker container

1. Navigate to the project's root directory ('/dungeons_and_development') in a terminal of your choice.
2. Run the folowing command to run the docker container using the compose file `docker compose up`
3. Wait for the container to spin up, this is indicated by the last two lines of the console looking similar to the below:
   dungeons_and_development-app-1 | \* Listening on http://0.0.0.0:3000
   dungeons_and_development-app-1 | Use Ctrl-C to stop
4. Navigate to http://0.0.0.0:3000 in your web browser
5. If you can see the landing page, you have succesfully run the containerised version of the application!

**Note:** If you have any issues spinning up the container, run the following command `docker compose down -v` before running `docker compose up`

## Technical Specs:

- Ruby version 3.2.2

- Rails version 7.1
- Database: PostgreSQL

- System dependencies...

- Configuration...
