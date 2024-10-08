require('dotenv').config()
const path = require('path')
const express = require('express')
const router = require('./app/routes/router')

const app = express()

app.use(express.static(path.resolve(__dirname, 'public')))
app.use(router)

app.listen(process.env.APP_PORT || 8000, () =>
  console.log(`Running on port ${process.env.APP_PORT || 8000}`))
