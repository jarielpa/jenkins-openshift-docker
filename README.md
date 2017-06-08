# Jenkins for OpenShift

This is a standalone Jenkins master, i.e. maven and jdk 8 are installed so it can build maven projects without slaves.
Image is based on openshift/jenkins-2-centos7

# Install

Install with OpenShift Jenkins template:

	https://github.com/openshift/openshift-ansible/tree/master/roles/openshift_examples/files/examples/v1.5/quickstart-templates 


Without template:

Jenkins needs to access OpenShift API to discover slave images as well accessing container images. 
Grant Jenkins service account enough privileges to invoke OpenShift API for the project in question:

    oc policy add-role-to-user edit system:serviceaccount:<project>:default -n <project>
    
	oc new-app -e JENKINS_PASSWORD=<password> <projec>/<image-name>:<version>

