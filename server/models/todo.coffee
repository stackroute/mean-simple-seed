mongoose = require 'mongoose'
Schema   = mongoose.Schema;


# Define the schema for the TODO model
TodoSchema = new Schema
  text: String

# make the todo model out of the TodoSchema
module.exports = mongoose.model 'Todo', TodoSchema
