express = require 'express'
router  = express.Router()

router.get '/', (req, res) ->

  test = req.user
  console.log test
  res.render 'index', {}


module.exports = router
