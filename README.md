Freshy Spa
==========

Simple online system to manage customer and service scheduling.

Features:

* Collaborators
* Services
* Customers
* Scheduling

## Windows setup

1. Download and install [RailsInstaller](http://railsinstaller.org/en) with Ruby 2.2.

2. Download and install [NodeJS](https://nodejs.org/en/).

3. Restart your computer to apply all the changes.

4. Open up a command line prompt (Choose "Run" from your start menu and type 'cmd.exe') and verify that you have Ruby installed:

  ```sh
  ruby -v
  ```
  It should respond with a version.
5. Verify that you have Ruby on Rails installed:

  ```sh
  rails --version
  ```
  If the last command does not show the current version of rails, run the following command, wait until finish, and check version again:
  
  ```sh
  gem install rails
  ```
  
## APP Setup

1. Using the command line prompt, change the current directory to the location where you want the cloned directory to be made.

  Example: 
  ```sh
  cd projects
  ```
2. Clone a copy of the repository:

  ```sh
  git clone https://github.com/BrunoHideo/freshy-spa.git
  ```
  If you are having trouble, check [this link](https://help.github.com/articles/cloning-a-repository/).
3. Change to the cloned directory:

  ```sh
  cd freshy-spa
  ```
4. Install all the libraries:

  ```sh
  bundle install
  ```
5. Setup the database:

  ```sh
  rake db:create db:migrate db:seed
  ```
6. Run rails server

  ```sh
  rails s
  ```

## Development Team

Project developed for the discipline of software engineering lab, of the ADS graduation course from FATEC SP, as partial requirement for the semester conclusion.

Bruno Hideo

Fabio Domi

Lucas Ponciano

Luiz Martins

Sergio Donatti
