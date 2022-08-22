pipeline{
    agent any
    stages{
        stage('build'){
            steps{
                sh '''
                cd /home/master/Downloads/BARfiles
                pwd
                #curl -v -u admin:admin --upload-file sample.bar http://localhost:8081/repository/tar/
                curl -u admin:admin --upload-file sample.bar  http://localhost:8081/repository/tar/$JOB_NAME/$BUILD_NUMBER/sample.bar    
                '''
            }
        }
    }
}
