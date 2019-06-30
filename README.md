# Cheese API

Playing around with server side swift and Vapor 3 with this cheese centered API.<br>

## Running a Docker MySQL Database
The three databases with Vapor support are sqlite, msql, and postgresql.<br><br>

This project uses MySQL as its database.<br><br>

To get this project running on your machine, 3 steps.
1. Get a Docker MySQL Database up and Running<br>
2. Clone the project to your machine<br>
3. Build and run the project<br><br> 

That is all. 🙃<br><br>

Haha. As if beginner Jessica would understand that shit. 😭<br>
OKAY, some more effort into the explanation, here we go<br><br>

Brace yourself, more detailed steps coming. Get your cup of water please<br><br>

### Docker Setup
You'll first want to get Docker up and running.<br><br>

Head over to the Docker website and start the download of the <a href="https://www.docker.com/products/docker-desktop">Docker Desktop Application</a><br>
Assuming the link hasn't changed, you should be able to click on 'Docker Desktop Application' above to be directed to the website.<br><br>

Cool, while that's downloading (can't remember if it took a while, let's assuming it does). Create a docker application. You'll need these credentials to log into the desktop application.<br>
No worries, you won't be charged for anything. F R E E. 💰👍🏾<br><br>

Up to this point you should have logged into the Docker desktop application with your docker credentials.<br>
Hold up, you haven't started any databases yet. You've set the stage so that you CAN start running databases.<br><br>

Open up a new Terminal window and type the command
```
docker run --name mysql -e MYSQL_DATABASE=vapor -e MYSQL_USER=vapor -e MYSQL_PASSWORD=password \
-p 3306:3306 -d mysql/mysql-server:5.7
```

Hey, Jessica. WTF, did I just type?<br><br>

Okay.
`docker run`
The docker command for running a docker database<br>

`--name mysql`
The database container I want to create can be identified with the name mysql. This is the name you will use when you want to stop, start, and  remove your database<br>

`-e MYSQL_DATABASE=vapor`
Setup the global variable for my mysql database to the value 'vapor'. This is the database reference that is used in your server's configure.swift file for setting up your databse configuration<br>

`-e MYSQL_USER=vapor`
Setup the global variable for my mysql user to the value 'vapor'. This is the username reference that is used in your server's configure.swift file for setting up your database configuration.<br>

`-e MYSQL_PASSWORD=password`
Setup the global variable for my mysql password to the value 'password'. This is the password reference that is used in your server's configure.swift file for setting up your database configuration.<br>

`-p 3306:3306`
Set the port for your docker database to run on port 3306. 3306 is the default MySQL port.<br>

`-d`
Set the database to be detached. Detached mode is when your database container is running in the background.<br>

`mysql/mysql-server:5.7`
Specifying which mysql server version to use. In this case, 5.7<br><br>

Alright, bitch. Welp. That was most of the work.<br>
Take a breathe, almost done.<br>

### Clone the project
Easiest method if you don't have ssh setup on your device is to download the zip and unzip it. bam.<br><br>

HOWEVER, you probably do have SSH setup. If not, but you're interested in doing so (a good thing to do for a secure connection between your machine and your github account). You can follow < a href="https://help.github.com/en/articles/connecting-to-github-with-ssh">this article</a> (Assuming the link hasn't changed since writing this 😬).<br>

Yay, project cloned, docker running. Time to build and run.<br> This is it.<br>

### Building and Running the Project
Pull up a new terminal window and change directory `cd` AKA navigate to your project's folder.<br>
First, you'll want to build your project's dependencies.<br>

`vapor build`

Now, run your project

`vapor run`

From here you can use the Postman or RESTed app to test your API endpoints.<br><br>

Yay, twerk time. 🍑🎉<br>
  

## Database Exploration
The main databases supported with Vapor include SQLite, MySQL, and PostgreSQL.<br>
That's cool, but what does that mean?<br><br>

What are their disadvantages and advantages? Appropriate use cases?<br><br>

#### SQLite
SQLite is a lightweight database used for simple local data storage.<br>
I have found this database type is most useful for data analysis/machine learning.<br>
For example local on device storage of an artificial intelligence model<br><br>

SQLite also shines when it comes to internet of things devices which often operate without human support.<br>
SQLite does not compete with client/server databases like MySQL or PostgreSQL.<br>
SQLite competes more with standard file management libraries such as fopen().

#### MySQL



<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>
