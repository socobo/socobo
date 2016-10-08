// Comment to get more information during initialization
logLevel := Level.Warn

// The Typesafe repository
resolvers += "Typesafe repository" at "http://repo.typesafe.com/typesafe/releases/"

// Use the Play sbt plugin for Play projects
addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.5.8")

addSbtPlugin("com.typesafe.sbt" % "sbt-play-enhancer" % "1.1.0")

addSbtPlugin("com.typesafe.sbt" % "sbt-play-ebean" % "3.0.0")

// Use the Typesafe Gzip plugin
addSbtPlugin("com.typesafe.sbt" % "sbt-gzip" % "1.0.0")

// Etsy stylecheck
addSbtPlugin("com.etsy" % "sbt-checkstyle-plugin" % "0.4.1")
