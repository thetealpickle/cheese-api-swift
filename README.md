# CheeseVapor API Template
⚠️ [FEATURE REFACTOR IN PROGRESS] ⚠️

<p align="center">
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>

HELLO! [@THETEALPICKLE](https://instagram/thetealpickle) HERE.
Are you a lazy backend coder who loves cheese? 
Then this is your template.

## BACKSTORY

In the alien hyperstream (the human equivalent of a mall), the substance known on earth as cheese 🧀 is sold as a highly corrosive weapon 🦠💣 capable of destroying species and slowing down thier higher consciousness evolution. Quite a useful tool in war 😬. Different planets culture varying toxic levels of cheese. <br>

The ultimate alien queen 👑 is sending out a squad to go to every planet and collect cheese data. The queen has an affinity for earth and wants to use human technology for the squad's data collection. To keep the technology authentically human, the queen had an actual human develop the technology.<br>

This is the API.

### WHO? 
🤖 CheeseVapor is a Swift based server based on cheese 🧀<br>

### WHAT? 
🙃 Features 🙃
- Authentication [Login/Token]
- Logging
- Model Testing
- Request Testing<br>

### HOW? 
🧠 Vapor 3, babyyyyyy 💨

## Running a Docker MySQL Database
The three databases with Vapor support are sqlite, msql, and postgresql.<br>
This project uses MySQL as its database.<br>

To get this project running on your machine, 3 steps.
1. Get a Docker MySQL Database up and Running<br>
2. Clone the project to your machine<br>
3. Build and run the project<br>

That is all. 🙃<br>

Haha. As if beginner Jessica would understand that shit. 😭<br>
OKAY, some more effort into the explanation, here we go<br>

Brace yourself, more detailed steps coming. Get your cup of water please<br>

### 1/3 Docker Setup
You'll first want to get Docker up and running.<br>

Head over to the Docker website and start the download of the <a href='https://www.docker.com/products/docker-desktop'>Docker Desktop Application</a><br>
Assuming the link hasn't changed, you should be able to click on 'Docker Desktop Application' above to be directed to the website.<br><br>

Cool, while that's downloading (can't remember if it took a while, let's assuming it does). Create a docker application. You'll need these credentials to log into the desktop application.<br>
No worries, you won't be charged for anything. F R E E. 💰👍🏾<br><br>

Up to this point you should have logged into the Docker desktop application with your docker credentials.<br>
Hold up, you haven't started any databases yet. You've set the stage so that you <b>CAN</b> start running databases.<br><br>

Open up a new Terminal window and type the command
```
docker run --name mysql -e MYSQL_DATABASE=vapor -e MYSQL_USER=vapor -e MYSQL_PASSWORD=password \
-p 3306:3306 -d mysql/mysql-server:5.7
```

Hey, Jessica. WTF, did I just type?<br><br>

Okay.

```docker run```

<i>The docker command for running a docker database</i>

```--name mysql```

<i>The database container I want to create can be identified with the name mysql. This is the name you will use when you want to stop, start, and  remove your database</i>

```-e MYSQL_DATABASE=vapor```

<i>Setup the global variable for my mysql database to the value 'vapor'. This is the database reference that is used in your server's configure.swift file for setting up your databse configuration</i>

```-e MYSQL_USER=vapor```

<i>Setup the global variable for my mysql user to the value 'vapor'. This is the username reference that is used in your server's configure.swift file for setting up your database configuration.</i>

```-e MYSQL_PASSWORD=password```

<i>Setup the global variable for my mysql password to the value 'password'. This is the password reference that is used in your server's configure.swift file for setting up your database configuration.</i>

```-p 3306:3306```

<i>Set the port for your docker database to run on port 3306. 3306 is the default MySQL port.</i>

```-d```

<i>Set the database to be detached. Detached mode is when your database container is running in the background.</i>

```mysql/mysql-server:5.7```

<i>Specifying which mysql server version to use. In this case, 5.7</i>

Alright, bitch. Welp. That was most of the work.<br>
Take a breathe, almost done.<br>

### 2/3 Clone the project
Easiest method if you don't have ssh setup on your device is to download the zip and unzip it. bam.<br>

<b>HOWEVER</b>, you probably do have SSH setup. 
If not, but you're interested in doing so (a good thing to do for a secure connection between your machine and your github account). You can follow <a href='https://help.github.com/en/articles/connecting-to-github-with-ssh'>this article</a> (Assuming the link hasn't changed since writing this 😬).

Yay, project cloned, docker running. Time to build and run.
This is it.

### 3/3 Building and Running the Project
Pull up a new terminal window and change directory `cd` AKA navigate to your project's folder.<br>
First, you'll want to build your project's dependencies.<br>

```vapor build```

Now, run your project

```vapor run```

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
MySQL was designed for speed and reliability, making it an ideal database for many use cases.<br>
Currently many large applications and sites such as Facebook, Spotify, and Netflix are powered by MySQL.<br>
MySQL's speed and reliability come at the cost of not fully being SQL compliant, so there are some functional limitations depending on your use case.<br><br>

Disadvantages of MySQL: [SQL compliance and functionality limitations, licence and propriety features, and slowed development]<br>
Advantages of MySQL: [security, speed, replication (useful for horizontal scaling), and popularity/ease of use]

#### PostgreSQL
PostgreSQL is the most advanced open-source relational database. PostgreSQL was designed to be highly extensible and standard compliant.<br>

---
<p align="center">
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>


