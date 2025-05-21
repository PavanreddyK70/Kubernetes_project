1. When developer pushes code to Github jenkins triggers automatically[ we used webhook]
2. In pipeline script the jenkins will ssh to Ansible server and copys the project files from jenkins to ansible
3. Inansible it will build the image and pushes it to dockerhub
4. create passwordless auth to K8s server and create one inventory file and in pipeline ssh to ansible and execute the ansible playbook file deployment.
![image](https://user-images.githubusercontent.com/35370115/150634956-54357760-c5b9-445c-b444-5b69e98e83b8.png)
