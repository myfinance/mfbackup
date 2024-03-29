pipeline {
 agent none

 environment{
   SERVICE_NAME = "mfbackup"
   MONGO_SERVICE_NAME = "mfmongobackup"
   ORGANIZATION_NAME = "myfinance"
   DOCKERHUB_USER = "holgerfischer"
   //Snapshot Version
   VERSION = "0.17.0-alpha.${BUILD_ID}"
   //Release Version
   //VERSION = "0.16.0"
   REPOSITORY_TAG = "${DOCKERHUB_USER}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${VERSION}"
   MONGO_REPOSITORY_TAG = "${DOCKERHUB_USER}/${ORGANIZATION_NAME}-${MONGO_SERVICE_NAME}:${VERSION}"
   K8N_IP = "192.168.100.73"
   DOCKER_REPO = "${K8N_IP}:31003/repository/mydockerrepo/"
   TARGET_HELM_REPO = "http://${K8N_IP}:31001/repository/myhelmrepo/"
   TEST_NAMESPACE = "mftest"
   DEV_NAMESPACE = "mfdev"
 }

 stages{
   stage('preperation'){
    agent {
        docker {
            image 'maven:3.6.3-jdk-8' 
        }
    }      
     steps {
       cleanWs()
       git credentialsId: 'github', url: "https://github.com/${ORGANIZATION_NAME}/${SERVICE_NAME}.git"
     }
   }
   stage('build and push Images'){
    agent {
        docker {
            image 'docker' 
        }
    }        
     steps {
       sh 'docker image build -t ${REPOSITORY_TAG} .'
       sh 'docker tag ${REPOSITORY_TAG} ${DOCKER_REPO}${REPOSITORY_TAG}'
       sh 'docker push ${DOCKER_REPO}${REPOSITORY_TAG}'

       sh 'docker image build -t ${MONGO_REPOSITORY_TAG} ./mongo'
       sh 'docker tag ${MONGO_REPOSITORY_TAG} ${DOCKER_REPO}${MONGO_REPOSITORY_TAG}'
       sh 'docker push ${DOCKER_REPO}${MONGO_REPOSITORY_TAG}'
     }
   }

   stage('deploy to cluster'){
     agent any
     steps {
       // sh 'envsubst < deploy.yaml | kubectl apply -f -'
       sh 'envsubst < ./helm/mfbackup/Chart_template.yaml > ./helm/mfbackup/Chart.yaml'
       sh 'helm package helm/mfbackup -u -d helmcharts/'
       sh 'curl ${TARGET_HELM_REPO} --upload-file helmcharts/mfbackup-${VERSION}.tgz -v'
       sh 'helm upgrade -i --cleanup-on-fail mfbackup ./helm/mfbackup/ -n ${DEV_NAMESPACE} --set stage=dev --set repository=${DOCKER_REPO}/${DOCKERHUB_USER}/${ORGANIZATION_NAME}-'
       sh 'helm upgrade -i --cleanup-on-fail mfbackup ./helm/mfbackup/ -n ${TEST_NAMESPACE} --set stage=test --set repository=${DOCKER_REPO}/${DOCKERHUB_USER}/${ORGANIZATION_NAME}-'
     }
   }
 }
}
