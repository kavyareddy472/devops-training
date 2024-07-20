pipeline {
  agent any

  tools { 
        maven "mymaven"
  }
  parameters {
    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
    booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
    choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
    }
  stages {
    stage('Compile') {
      when {
        expression {
          params.TOGGLE == true
        }
      }  
      steps {
        echo "compiling teh code ${params.PERSON}"
      }        
    }
    stage('UnitTest') {
      steps {
        echo "Test teh code ${params.CHOICE}"
      }
    }
    stage('Package') {
       steps {
          echo "Package teh code"
       }
    }
    stage('deploy') {
      input {
        message "please enter the env to build on"
        parameters { 
          choice(name: 'ENVi', choices: ['prod','cob','pte'], description: 'pick the environment')
        }
      }
      steps {
          echo "Package teh code"
      }
    }
  }
}

