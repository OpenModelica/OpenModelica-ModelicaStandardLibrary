pipeline {
  agent none
  options {
    newContainerPerStage()
  }
  environment {
    LC_ALL = 'C.UTF-8'
  }
  stages {
  stage('update') {
    agent {
      label 'linux'
    }
    environment {
      HOME = '/tmp/dummy'
    }
    steps {
      sshagent (credentials: ['Hudson-SSH-Key']) {
        sh 'mkdir -p ~/.ssh/'
        sh 'ssh-keyscan github.com >> ~/.ssh/known_hosts'
        sh '''
        git remote add MA-remote https://github.com/modelica/ModelicaStandardLibrary.git || true
        git remote set-url MA-remote https://github.com/modelica/ModelicaStandardLibrary.git
        git remote add github git@github.com:OpenModelica/OpenModelica-ModelicaStandardLibrary.git || true
        git remote set-url github git@github.com:OpenModelica/OpenModelica-ModelicaStandardLibrary.git
        '''
        sh 'git fetch MA-remote --no-tags'
        sh '''
        export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
        git clean -fdx
        for br in master maint/2.2.1 maint/2.2.2 maint/3.0 maint/3.0.1 maint/3.1 maint/3.2 maint/3.2.1 maint/3.2.2 maint/3.2.3 maint/4.0.x maint/4.1.x; do
          git checkout MA/$br
          git reset --hard MA-remote/$br
          git push github MA/$br
        done

        for br in maint/2.2.2 maint/3.1 maint/3.2.1 maint/3.2.2; do
          git checkout OM/$br
          git reset --hard origin/OM/$br
          git merge MA/$br
          git push github OM/$br
        done

        git fetch origin

        for br in master trunk maint/3.2.3 maint/4.0.x maint/4.1.x; do
          git checkout OM/$br
          git reset --hard origin/OM/$br
          ./update.sh
          git clean -fdx
        done
        '''
      }
    }
  }
  }
}
