package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	//"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestApplySingleSubnet(t *testing.T) {
	t.Parallel()

	// Root folder where Terraform files should be (relative to the test folder)
	rootFolder := "../"

	// Path to Terraform example files for testing (relative to the root folder)
	terraformFolderRelativeToRoot := "./examples/"

	// Copy the terraform folder to a temp folder to prevent conflicts from parallel runs
	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	// Generate a random deployment name for the test to prevent a naming conflict
	uniqueID := random.UniqueId()
	testREF := "SingleSubnet"
	serviceDeployment := testREF + "-" + uniqueID

	// Define variables
	//locations := []string{"UK South"}
	locations := "UK South"

	// Concatenate expected resource group name
	//resourceGroupName := "Services-Test-UKS-" + serviceDeployment + "-rg"

	// Enable retryable error
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		// The path to where the Terraform code is located
		TerraformDir: tempTestFolder,

		// Variables to pass to the Terraform code using -var options
		Vars: map[string]interface{}{
			"service_deployment":            serviceDeployment,
			"service_location":              locations,
			"resource_network_subnet_count": 1,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	//output := terraform.Output(t, terraformOptions, "resourceGroupName")
	//assert.Equal(t, resourceGroupName, output)
}
