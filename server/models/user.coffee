mongoose              = require 'mongoose'
Schema                = mongoose.Schema
passportLocalMongoose = require 'passport-local-mongoose'


# The user model. Mainly for auth with passport
UserSchema = new Schema
  username: String
  password: String
  email:    String

UserSchema.plugin passportLocalMongoose

# compile the model from schema
module.exports = mongoose.model 'User', UserSchema
