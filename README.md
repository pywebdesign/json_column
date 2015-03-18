#Simple Rails dev env with postgresql and postgis

##Usage
Install Docker and docker-compose, try google!

1. run:
`. setup.sh`
1. wait..., say yes, wait...
1. then start the dev server:
`docker-compose up`

look your new server is running on localhost:3000

You can edit you rails app files in host and they will be instantly sync with your docker container running your dev server.

Don't want to wait for every project to install the same gems? Copy paste the vendor/bundle from a previous installation.

##Customize
You can easily switch to postgis by changing line 8 in fig.yml to:
`image: "pywebdesign/postgis"`

Be sure to also change line 2 in database.setup.yml file to:
`adapter: postgis`

## Notes
If you want to run rake or rails command like `rails generate model cafe...` you must do so in the docker container. Just add docker-compose run web before each command like so:

`docker compose run web rake db:migrate`

### Generated files
generated files wont be yours, just run `. unlock.sh` to get ownership after generating them!
