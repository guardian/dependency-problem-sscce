ThisBuild / scalaVersion     := "3.3.3"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "com.example"
ThisBuild / organizationName := "example"

lazy val root = (project in file("."))
  .settings(
    name := "dependency-problem-sscce",
    libraryDependencies += "com.typesafe.akka" % "akka-actor_2.13" % "2.6.21"

  )
