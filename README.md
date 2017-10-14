# civitasCRM

civitasCRM is our final year project, built in Rails, for the CSIT321 subject. Find more information at our [marketing page](http://www.civitascrm.com.au/).

## Versions
  * Ruby: 2.3.3
  * Rails: 5.0.6

## Setup
_Note:_ This project uses the MiniMagick gem, which means that [ImageMagick](https://www.imagemagick.org/script/index.php) will need to be locally installed.

To setup the project locally, first clone the repository.
```bash
git clone https://github.com/benJervis/civitas-crm.git
```
Run bundler, to install the gems required.
```bash
cd civitas-crm
bundle install
```
Load the schema of the database.
```bash
rails db:schema:load
```
If you want some data to work with, there is seed data available.
```bash
rails db:seed
```
Finally, start the server.
```bash
rails server
```
