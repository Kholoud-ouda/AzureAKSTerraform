pipeline { 
    agent any
		
    environment {
    ENV	= 'dev'
    }

   stages 
   {
	   
    	stage('Configure Provider File')
	    {
	        steps 
            {
                sh '''
                    echo '
terraform {
    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
        }
    }
}

provider "azurerm" {
features {}

    subscription_id   =' "$subscription_id"'
    tenant_id         =' "$tenant_id"'
    client_id         =' "$client_id"'
    client_secret     =' "$client_secret"'
}
                    ' > provider.tf

                '''
		    }
	    }
    	stage('Initialize the Repo')
	    {
            steps 
            {
                sh ''' 
                    terraform init
                '''
            }
        }
        stage('Terraform plan')
	    {
            steps 
            {
                sh ''' 
                    terraform plan -input=false
                '''
            }
        }
        stage('Approval') 
        {  
            steps 
            {
                script 
                {
                  def userInput = input(id: 'confirm', message: 'Do you want to perform these actions above?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
        stage('Terraform Apply') 
        {  
            steps 
            {
                sh ''' 
                    terraform apply -input=false -auto-approve
                '''
            }
        }
    }
}
