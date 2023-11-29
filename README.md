<div align="center">
<a href="https://github.com/EvgeniySaschenko/newcatalog">
    <img src="https://evgeniysaschenko.github.io/newcatalog/logo-bg.png?v=2">
</a>
</div>

<br>

<div align="center">
    <a href="#description"><b>Description</b></a> |
    <a href="#install"><b>Install</b></a> |
    <a href="#development"><b>Development</b></a> |
    <a href="#about-development"><b>About development</b></a> |
    <a href="#other"><b>Other</b></a>
</div>

-----------------------------------------------------------------------------------------------------------------
<a name="description"></a>

## Description 
<b>NEWCATALOG</b> is a content management system (CMS) that allows you to create catalogs / ratings of websites.

This CMS allows you to quickly create a collection of web pages and better structures the data when compared with non-specialized CMS in the task of creating a subset of web pages.

> ❗️ This is not yet a stable version of the CMS, it will change and may contain critical bugs. I plan to gradually refactor and add new functionality.

<b>Demo admin panel:</b> https://newcatalog-admin.ua-ix.biz/

The manual for the demo mode is in this repository, file <b>manual-demo.pdf</b>

<b>Functional:</b>

- Creation collections of web pages
- Creation screenshots of web pages
- The site logo can be created in the browser (cut from the screenshot)
- You can add new languages through the browser interface
- You can change the appearance of the website (logos, colors)
- You can add your own scripts / styles / banners
- It is possible to make a backup
- You can install your own SSL certificates

<b>What is shown on the logo?</b>

In some programming languages, the <b>"new"</b> operator is used to create an instance of a class using a constructor class, <b>"Catalog"</b> is a constructor class for creating catalogs, <b>"#"</b> - data references are passed in parentheses.

```js
new Catalog(#);
```
<b>Tools</b> 

<div align="center">
    <a href="https://vuejs.org/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/vue.png?v=2" align="center" height="50">
    </a>
    <a href="https://pugjs.org/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/pug.png?v=2" align="center" height="50">
    </a>
    <a href="https://element-plus.org/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/elements-plus.png?v=2" align="center" height="50">
    </a>
    <a href="https://nuxt.com/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/nuxt.png?v=2" align="center" height="50">
    </a>
    <a href="https://www.typescriptlang.org/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/typescript.png?v=2" align="center" height="50">
    </a>
    <a href="https://nginx.org/en/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/nginx.png?v=2" align="center" height="50">
    </a>
    <a href="https://redis.io/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/redis.png?v=2" align="center" height="50">
    </a>
    <a href="https://nodejs.org/en">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/nodejs.png?v=2" align="center" height="50">
    </a>
    <a href="https://www.docker.com/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/docker.png?v=2" align="center" height="50">
    </a>
    <a href="https://www.postgresql.org/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/postgres.png?v=2" align="center" height="50">
    </a>
    <a href="https://sequelize.org/">
        <img src="https://evgeniysaschenko.github.io/newcatalog/tools/sequelize.png?v=2" align="center" height="50">
    </a>
</div>

-----------------------------------------------------------------------------------------------------------------
<a name="install"></a> 

## Install 

> The commands described here were run on <b>Ubuntu</b> (don't forget that you can install <a href="https://www.virtualbox.org/">Virtualbox</a>)

> ❗️You must follow the instructions exactly, all commands must be executed by the <b>run.sh</b> script, for example if you try to install node_modules without <b>run.sh</b> it may cause permission problems.

> ❗️This description assumes installing 1 instance of "newcatalog" per server. Also, ports 80 and 443 must be free.

<a name="install-programs"></a>

1. Install such programs if they are not installed on your operating system: 
<a href="https://www.docker.com/">Docker</a>, <a href="https://git-scm.com/">GIT</a>, <a href="https://en.wikipedia.org/wiki/Bash_(Unix_shell)">Bash</a>

<i>To check for the existence of a program, you can run the following commands on the command line: docker --version, git --version, bash --version. If the version is displayed on the command line, then the program is installed.</i>

<a name="install-git-clone"></a>

2. Run this command in the GIT console to download the repositories to your computer

```bash
git clone --recurse-submodules git@github.com:EvgeniySaschenko/newcatalog.git
```

<br>

3. <b>(OPTIONAL)</b> In the production <b>.env-custom</b> file, some variables will need to be added before running (see example <b>.env-prod</b> file):

* SITE__DOMAIN - Your domain website
* ADMIN__DOMAIN- Your domain admin panel
* API__PASSWORD_SALT - <b>(OPTIONAL)</b> The string that will encrypt your password in the database.

> ❗️It is important to remember that when synchronizing / updating the project, you can overwrite your changes in the <b>.env-custom</b> file. So it's better to save it additionally somewhere else

4. Go to the project directory and run the file <b>run.sh</b>

```bash
# Go to directory
cd newcatalog

# Run the file
bash run.sh prod init
```

<i>If the installation fails, try running this command again. The error may be related to the unavailability at the moment of the servers hosting the software packages ("npm", "docker", etc.).</i>

<a name="install-browser-open"></a>


5. After the installation is completed, the site will become available in the browser at the address: 

<b>Website:</b> https://newcatalog.localhost or your domain

<b>Admin panel:</b> https://admin.newcatalog.localhost or your domain

<b>Login:</b> default@newcatalog.email

<b>Password:</b> 123456

-----------------------------------------------------------------------------------------------------------------
<a name="development"></a>

## Development 

1. <a href="#install-programs">Install the necessary programs</a>

2. <a href="#install-git-clone">Clone the project</a>

3. Add the current user user to the "docker" group and be sure to restart the computer. This will give "root" permissions in "docker" containers to the current user of the host machine - necessary for "ESLint" and other "Visual Studio Code" plugins to work

```bash
sudo usermod -aG docker ${USER}
```

4. Install plugins "Visual Studio Code":

* ESLint
* Prettier - Code formatter
* Vetur
* Sass (.sass only)
* PostgreSQL
* GitLens — Git supercharged

4. Initialize the project 

```bash
bash run.sh dev init
```
5. <a href="#install-browser-open">Open in browser</a>
<br>

6. Run commands in the project directory:

<b>Stop the services</b>
```bash
bash run.sh dev stop
```
or

```bash
Ctrl + C
```
<b>Run the services</b>
```bash
bash run.sh dev up
```
<b>Run the backup server</b>
> ❗️ In development mode, you need to start it manually
```bash
docker exec -it newcatalog__service--db-main node server.js
```
<b>Create a production build</b>
```bash
bash run.sh prod build
```
<b>Upload on Github</b>
> ❗️ In order for submodule changes to be reflected in the root repository, you must add the submodule to the GIT history of the main module each time. For example (being in the "newcatalog" directory): 

```bash
git add service--admin
git add service--site
git add service--...
git git commit "...."
git git push ....
```

-----------------------------------------------------------------------------------------------------------------
<a name="about-development"></a>
## About development

Some principles that will help you understand how the project works:

1. Constant / default values - in most cases I define them in <b>config</b> or <b>.env-*</b> files, this saves me from having to remember where these values are used (when something changes in the program, this is important).

2. In <b>.env-*</b> files, the values ​​necessary for starting the project or which are used in several services are mainly defined (so as not to duplicate the value).

3. In config files, define values for a specific service.

4. Plugins folder - in most cases, these are functions that are intended to be used throughout the project. 

5. Prefixes in names - a unique prefix helps you quickly find a specific type of code, for example:

```js
this.$api['ratings'].getRating({ ratingId })
```
If you type `this.$api['ratings']` in the editor, you will find all the code related to `$api['ratings']`.

6. Request libraries - it's better to group requests into libraries, this allows you to quickly find the desired request and also make changes easier. For example: <b>plugins/db-main</b> and <b>plugins/api</b>


7. In many cases, parameters are passed to a function explicitly as an object:

* This ensures that some other parameters were not accidentally passed (for example, extra parameters were sent from the frontend, and the backender used them, and then they were deleted on the frontend)
* Passing as an object - in the object it is not required to follow the sequence of passing parameters, which allows to avoid errors associated with this
* You can immediately see what parameters are being passed.

```js
// Good
ditRating({
    ratingId,
    name,
    descr,
    linksToSources,
    isHiden,
    sectionsIds,
    typeSort,
    typeDisplay,
    typeRating,
  })

// Bad (In most cases)

ditRating(rating)
```

8. The name of the id (primary key) field in the database - it's better to call it not just id , but the name of the table in a single number + id - for example: <b>ratingId</b>, <b>sectionId</b>... This is much clearer, especially when linking tables.

9. <b>Nesting of data that is sent by the backend and the folder structure of the project.</b> The structure of the project should tend to be flat so as not to turn into a <b>pyramid</b>, but the hierarchy is also needed so that the project does not become <b>chaotic</b>.

10. In most cases, it is convenient to stick to a hierarchy in the names of fields / variables - for example:

<b>ratingId, ratingName</b> - displays nesting in rating

<b>idRating, nameRating</b> - does not display nesting

11. It is necessary to remember that in node.js scripts can save the previous state of object variables/fields after each call, <b>in some cases this can lead to errors.</b>

For example: <br>

❌ Data is accumulated in an array

```js
// File - user.js
let myArray = [];
module.exports = {
    myArray: [],
    pushToArray(value) {
        myArray.push(value); // 1. The variable is declared above "module.exports"
        this.myArray.push(value); // 2. Data is saved in a field of the exported object
        global.myArray.push(value); // 3. The variable is global
    },
};

// Calling a route
let user = require('./user.js');
router.get('/', async (request, response, next) => {
    user.pushToArray(123);
});
```

✅ Data is not accumulated in an array <br>
To avoid accidentally saving state, you can create an object each time using the “new” operator, and save the data in the object field.

```js
// File - user.js
class User {
    myArray: [],
    pushToArray(value) {
        this.myArray.push(value);
    },
};
module.exports = User;

// Calling a route
let User = require('./user.js');
router.get('/', async (request, response, next) => {
    let user = new User();
    user.pushToArray(123);
});
```

-----------------------------------------------------------------------------------------------------------------

<a name="other"></a>
## Other 

<b>User</b>

> ❗️Right now there is only 1 user. At the same time, one user can have only 1 session, you cannot log in from several devices. The session lifetime is 20 minutes, if you work in "incognito browser mode" and close the tab without logging out, you will not be able to log in until the session ends, this also applies to changing the user agent.

> ❗️Also important. For the user, the password recovery mechanism is not currently implemented, for recovery you will need to use the server console

<b>Commands:</b>

To run these commands go to the project directory


<b>Stop the services:</b>

```bash
bash run.sh prod stop
```

<b>Start the services:</b>

```bash
bash run.sh prod start
```

<b>Download updates:</b> 
> ❗️At this stage of development, the functionality may change and be removed, so the update may cause the current code to be in a non-working state.

```bash
bash run.sh prod stop
git pull --recurse-submodules git@github.com:EvgeniySaschenko/newcatalog.git
bash run.sh prod start
```

<b>Website analytics:</b>

You can add your own scripts through the settings in the admin panel (for example, Google Tag Manager). Some elements have data attributes data-analyzed-element , data-analyzed-element-data can be used to get data