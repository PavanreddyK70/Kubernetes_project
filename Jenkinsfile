node {
    stage('Checkout') {
        git branch: 'main', url: 'https://github.com/PavanreddyK70/Kubernetes_project.git'
    }

    stage('Send Docker Files to Ansible Host') {
        sshagent(['ansible_demo']) {
            sh '''
                set -e
                ssh -o StrictHostKeyChecking=no ec2-user@13.126.8.102 "mkdir -p /home/ec2-user/project"
                scp -o StrictHostKeyChecking=no -r * ec2-user@13.126.8.102:/home/ec2-user/project/
            '''
        }
    }

    stage('Send Files from Ansible Host to Kubernetes Host') {
        sshagent(['ansible_demo']) {
            sh '''
                set -e
                ssh -o StrictHostKeyChecking=no ec2-user@13.126.8.102 "
                    mkdir -p /home/ec2-user/k8s_files &&
                    scp -o StrictHostKeyChecking=no -r /home/ec2-user/project/* ec2-user@3.109.60.93:/home/ec2-user/k8s_files/
                "
            '''
        }
    }

    stage('Docker Build Image on Ansible Host') {
        sshagent(['ansible_demo']) {
            sh """
                set -e
                ssh -o StrictHostKeyChecking=no ec2-user@13.126.8.102 '
                    cd /home/ec2-user/project && \
                    docker build -t dockerpavank/${JOB_NAME}:v1.${BUILD_ID} .
                '
            """
        }
    }

    stage('Push Image to DockerHub') {
        sshagent(['ansible_demo']) {
            withCredentials([string(credentialsId: 'dockerhub_password', variable: 'DOCKER_PASSWORD')]) {
                sh """
                    set -e
                    ssh -o StrictHostKeyChecking=no ec2-user@13.126.8.102 '
                        echo "${DOCKER_PASSWORD}" | docker login -u dockerpavank --password-stdin && \
                        docker push dockerpavank/${JOB_NAME}:v1.${BUILD_ID}
                    '
                """
            }
        }
    }

    stage('Kubernetes Deployment using Ansible') {
        sshagent(['ansible_demo']) {
            sh """
                set -e
                ssh -o StrictHostKeyChecking=no ec2-user@13.126.8.102 '
                    cd /home/ec2-user/project && \
                    ansible-playbook -i inventory ansible.yml
                '
            """
        }
    }
}
