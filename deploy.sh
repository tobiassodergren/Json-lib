#!/bin/sh
VERSION="2.4.1"
GROUPID="net.sf.json-lib"
ARTIFACTID="json-lib-im"
REPO_URL="http://repository.infomaker.se/content/repositories/thirdparty"
REPOSITORYID="repository.infomaker.se"

mkdir build
ant source.jar
mv target/${ARTIFACTID}-${VERSION}-jdk13-sources.jar build
ant source.jar.jdk5
mv target/${ARTIFACTID}-${VERSION}-jdk15-sources.jar build
ant javadoc
mv target/${ARTIFACTID}-${VERSION}-jdk13-javadoc.jar build
ant javadoc.jdk5
mv target/${ARTIFACTID}-${VERSION}-jdk15-javadoc.jar build
ant jar
mv target/${ARTIFACTID}-${VERSION}-jdk13.jar build
ant jar.jdk5
mv target/${ARTIFACTID}-${VERSION}-jdk15.jar build

echo "Press [Enter] to start deployment to server"
read -s

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -DgeneratePom=false \
    -Dclassifier=jdk13-javadoc \
    -Dfile=build/${ARTIFACTID}-${VERSION}-jdk13-javadoc.jar

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -DgeneratePom=false \
    -Dclassifier=jdk15-javadoc \
    -Dfile=build/${ARTIFACTID}-${VERSION}-jdk15-javadoc.jar

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -DgeneratePom=false \
    -Dclassifier=jdk13-sources \
    -Dfile=build/${ARTIFACTID}-${VERSION}-jdk13-sources.jar

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -DgeneratePom=false \
    -Dclassifier=jdk15-sources \
    -Dfile=build/${ARTIFACTID}-${VERSION}-jdk15-sources.jar

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -DgeneratePom=false \
    -Dclassifier=jdk15 \
    -Dfile=build/${ARTIFACTID}-${VERSION}-jdk15.jar

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=jar \
    -DgeneratePom=false \
    -Dclassifier=jdk13 \
    -Dfile=build/${ARTIFACTID}-${VERSION}-jdk13.jar

mvn deploy:deploy-file -DrepositoryId=${REPOSITORYID} \
    -Durl=${REPO_URL} \
    -DgroupId=${GROUPID} \
    -DartifactId=${ARTIFACTID} \
    -Dversion=${VERSION} \
    -Dpackaging=pom \
    -DgeneratePom=false \
    -Dfile=pom.xml
