# jenkins-openshift-docker

This is a standalone Jenkins master, i.e. maven and jdk 8 are installed so it can build maven projects without slaves.

    oc new-app -e JENKINS_PASSWORD=<password> jalammas/jenkins-openshift-docker

## In case of "manifest unknown# - error:
 
    oc new-app jalammas/jenkins-openshift-docker -o yaml > jenkins-openshift-docker.yaml

### In the YAML file, remove the ImageStream definition. The block of YAML to remove starts with:

	 - apiVersion: v1
	   kind: ImageStream
	   metadata:
	    annotations:
	  - until... dockerImageRepository: ""

You want to remove everything up until (NOT INCLUDING) the next “- apiVersion” line that is associated with another object — the dockerImageRepository stanza is the last line to remove. 


### UPDATE THE DEPLOYMENTCONFIG

The DeploymentConfig object tells OpenShift the configuration for how to deploy something. One of the things in the DeploymentConfig is the template for the Pod, which details the containers that will be run and from what image they are derived. In your text editor, you will see the DeploymentConfig has a section that talks about image change:
     
    - imageChangeParams:
        automatic: true
        containerNames:
        - jenkins-openshift-docker
        from:
          kind: ImageStreamTag
          name: jenkins-openshift-docker:latest
      type: ImageChange  
      
ImageStreams are used to track images in registries, and, because of the schema problem, we can’t do that. So, simply disable the image change trigger by removing this entire section.

###
Jenkins needs to access OpenShift API to discover slave images as well accessing container images. 
Grant Jenkins service account enough privileges to invoke OpenShift API for the project in question:

    oc policy add-role-to-user edit system:serviceaccount:<project>:default -n <project>

### SAVE, EXIT, CREATE

At this point you can simply save the file, exit your editor, and then use “oc create” to create all of the objects:

    oc create -f jenkins-openshift-docker.yaml
