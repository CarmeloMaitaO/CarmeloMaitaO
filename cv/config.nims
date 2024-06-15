#!/usr/bin/env -S nim e --hints:off
switch("hints", "off")
mode = ScriptMode.Silent

const format = staticRead("cv.typst")

proc generateCV(dir: string) =
  let dataFile = dir & "cv.json"
  let translationFile = dir & "translations.typst"
  let data = "#let cv = json(\"" & dataFile & "\")"
  let translations = staticRead(translationFile)
  let tmp = data & "\n" & translations & "\n" & format
  writeFile("tmp.typst", tmp)
  exec("typst compile " & "tmp.typst " & "cv.pdf")
  rmFile("tmp.typst")

task spa, "Generates the CV in spanish":
  generateCV("spanish/")

task eng, "Generates the CV in english":
  generateCV("english/")

task ita, "Generates the CV in italian":
  generateCV("italian/")
