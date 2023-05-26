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
    <a href="#other-commands"><b>Other commands</b></a>
</div>

-----------------------------------------------------------------------------------------------------------------

## Description <a name="description"></a>
<b>NEWCATALOG</b> is a content management system (CMS) that allows you to create catalogs / ratings of websites.

> ❗️ This is not yet a stable version of the CMS, it will change and may contain critical bugs. I plan to gradually refactor and add new functionality.

<b>Demo admin panel:</b> https://demo-admin.newcatalog.net

<b>My website:</b> https://newcatalog.net

<b>Functional:</b>

- Creating sections and collections of sites in these sections
- Create screenshots of websites
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

## Install <a name="install"></a>

> The commands described here were run on <b>Ubuntu</b>

1. Install such programs if they are not installed on your operating system: <a name="install-programs"></a>
<a href="https://www.docker.com/">Docker</a>, <a href="https://git-scm.com/">GIT</a>, <a href="https://en.wikipedia.org/wiki/Bash_(Unix_shell)">Bash</a>

<i>To check for the existence of a program, you can run the following commands on the command line: docker --version, git --version, bash --version. If the version is displayed on the command line, then the program is installed.</i>

<br>

2. Run this command in the GIT console to download the repositories to your computer <a name="install-git-clone"></a>

```bash
git clone --recurse-submodules git@github.com:EvgeniySaschenko/newcatalog.git
```
<br>

3. File <b>.env-prod</b> (optional). For production, before starting, you will need to change the values ​​of these variables <b>PROJECT_NAME, SITE__DOMAIN, ADMIN__DOMAIN, API__PASSWORD_SALT</b> and the name of the folder with the project 
<br>

4. Go to the project directory and run the file <b>run.sh</b>

```bash
# Go to directory
cd newcatalog

# Run the file
sudo bash run.sh prod init
```
<br>

5. After the installation is completed, the site will become available in the browser at the address: <a name="install-browser-open"></a>

<b>Website:</b> https://newcatalog.localhost or your domain
<b>Admin panel:</b> https://admin.newcatalog.localhost or your domain

<b>Login:</b> default@newcatalog.email
<b>Password:</b> 123456

-----------------------------------------------------------------------------------------------------------------
## Development <a name="development"></a>

1. <a href="install-programs">Install the necessary programs</a>

2. <a href="install-git-clone">Clone the project</a>

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

6. Other commands

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
<b>Create a production build</b>
> ❗️ In order for submodule changes to be reflected in the root repository, you must add the submodule to the GIT history of the main module each time. For example (being in the "newcatalog" directory): 

```bash
git add service--admin
git add service--site
git add service--...
git git commit "...."
git git push ....
```

-----------------------------------------------------------------------------------------------------------------

## Other commands <a name="other-commands"></a>

To run these commands go to the project directory


<b>Stop the services:</b>

```bash
sudo bash run.sh prod stop
```

<b>Start the services:</b>

```bash
sudo bash run.sh prod start
```

<b>Download updates:</b> 
> ❗️At this stage of development, the functionality may change and be removed, so the update may cause the current code to be in a non-working state.

```bash
sudo bash run.sh prod stop
git pull --recurse-submodules git@github.com:EvgeniySaschenko/newcatalog.git
sudo bash run.sh prod start
```