pipeline {
    agent none  // we will specify agents per stage

    stages {
        stage('Parallel Tasks') {
            parallel {
                stage('Task 1 - Java Version') {
                    agent {
                        kubernetes {
                            label 'jenkins-agent1'
                            defaultContainer 'jnlp'
                        }
                    }
                    steps {
                        sh 'java -version'
                    }
                }

                stage('Task 2 - Print Date') {
                    agent {
                        kubernetes {
                            label 'jenkins-agent1'
                            defaultContainer 'jnlp'
                        }
                    }
                    steps {
                        sh 'date'
                    }
                }

                stage('Task 3 - Print Hostname') {
                    agent {
                        kubernetes {
                            label 'jenkins-agent1'
                            defaultContainer 'jnlp'
                        }
                    }
                    steps {
                        sh 'hostname'
                    }
                }
            }
        }
    }
}

