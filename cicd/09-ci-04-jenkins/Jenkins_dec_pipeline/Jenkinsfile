pipeline {
    agent {
        label 'linux'
    }

    stages {
        stage('Checkuot SCM') {
            steps {
                git branch: 'main', credentialsId: 'b8b09eaa-f7fe-4fc0-9f4b-e425da808365', url: 'git@github.com:ivan-titovich/vector-role.git'
            }
        }
        stage('Insatall molecule') {
            steps{
                sh "pip3 install molecule molecule_podman"
            }
        }
        stage('Init role') {
            steps{
                sh "ansible-galaxy role init vector-role --force"
            }
        }
        stage('Molecule test') {
            steps{
                sh "molecule test -s ubuntu_podman"
            }
        }

    }
}
