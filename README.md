# jira-xray-scripts
scripts to upload results in jira using xray 

1. Command can be used from git bash to upload results in jira.
     sh "sh import_results.sh "AB-1234" "sample test summary" "sample test plan description" "UAT"

2. Command can be used in jenkins pipeline stage 

       stage('import results into jira') {
          when { expression { return params.JIRA } }
          steps {
              sh "echo importing results  in $params.issue_or_tag for $params.summary with $params.description"
              sh "sh import_results.sh $params.testplanissue $params.summary $params.description $params.testenvironment"
           }
       }
