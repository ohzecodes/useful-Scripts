# FreeBSD Mac version

read -p "dirrectory name: " dir
mkdir $dir
mkdir public src
touch ./public/index.html
touch ./src/index.js


cd $dir
npm init -y 1> /dev/null

sed -i '' '/"scripts":/ a\
   "dev": "nodemon app.js",\
   "start": "node app.js",\
   "watch": "webpack --watch",
    ' package.json

cat package.json

printf "%s\n" "this script will install the following npm modules:"
printf "%-21s\t%-21s\t%-21s\n" \
"dotenv"  "ejs"  "express"  \
"mongoose" "nodemon"  "react"  \
"axios"  "babel-loader"  "css-loader"  \
"react-dom" "style-loader"  "webpack" "webpack-cli" \
"@babel/core"  "@babel/preset-env"  "@babel/preset-react" \


read -p "do you want to continue installing [y/n]" y
if [ "$y" = "y"  ]; then
npm install              \
    @babel/core          \
    @babel/preset-env    \
    @babel/preset-react  \
    axios                \
    babel-loader         \
    css-loader           \
    dotenv               \
    ejs                  \
    express              \
    mongoose             \
    nodemon              \
    react                \
    react-dom            \
    style-loader         \
    webpack              \
    webpack-cli --silent 1>/dev/null




printf "\n%s\n" "modules installed "

cat <<- HERE > app.js
let express = require('express');
let app = express();
app.use(express.json());// this is important forreq.body
app.use(express.static('public'));
   app.get('/', (req, res) => {
        res.send('hello there')
         });

/*
error handler
//FIXME
app.use ((err,req,res,next)=>{ res.send(err.message);next();});
// route
app.get("/error/:param1",(req,res,next)=>{ if(req.params.param1=='err'){var err=new Error("not here");next(err);} else return {res.send()}});
 // but send something
*/

    app.set('port', process.env.PORT || 8080);
    let server = app.listen(app.settings.port, () => {
    console.log('Server ready on ', app.settings.port);
         });


HERE

cat <<- ASDF > webpack.config.js
const path = require('path');
module.exports = {
mode:"development",
devtool:"source-map",
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'public')
  },
    module: {
        rules: [
            {
              test:/\.css$/,
              use:['style-loader', 'css-loader']
            },
            { test: /\.m?js$/,
              use: {
                loader: 'babel-loader',
                options: {
                  presets: ['@babel/preset-env', '@babel/preset-react' ]
                }
              }
            },
            {test: /\.(png|jpg)$/,
            use: 'url-loader?limit=8192'
            }
        ]
    }

};
ASDF




cat <<- QWERT > ./public/index.html

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sample</title>
</head>
<body>
    <div id="root"></div>
    <script type="text/javascript" src="./bundle.js"></script>
</body>
</html>

QWERT



cat <<- MERT > ./src/index.js

import React from 'react';
import ReactDOM from 'react-dom';

function X(){
    var style ={padding: "80px", textAlign: "center",background: "#1abc9c", color: "white"}
return <div style={style} >
  <h1>My Website</h1>
  <p>A React Website</p>
</div>
}

var r=document.getElementById('root');
ReactDOM.render(<X/>,r);

MERT

read -p "press any key to run "
npm run dev
else
pwd | rev | cut -d "/" -f 1 | rev
read -p "answer was NO; press any key to delete the folder "
cd ..
rm -rf "$dir"
exit 1
fi


open http://localhost:8080/
