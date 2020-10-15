Red Hat Process Automation Manager Mortgage Demo
================================================
This demo project showcases the tooling available in Red Hat Process Automation Manager implementing complex decision 
logic and process automation for a financial mortgage home loan application. The mortgage project in this demo uses 
technical rules, decision tables, guided rules, user tasks, task forms, and process automation  to define its 
mortgage home loan calculations and approval system. You'll be running this demo through the process automation 
business central dashboard.

You can install this project on an OpenShift Container Platform.


Installing on any OpenShift Container Platform (generic)
--------------------------------------------------------
This demo can be installed on Red Hat OpenShift in various ways. We'll explain the different options provided.

All installation options require an `oc` client installation that is connected to a running OpenShift instance. More information on OpenShift and how to setup a local OpenShift development environment based on the Red Hat Container Development Kit can be found [here](https://developers.redhat.com/products/cdk/overview/).

---
**NOTE**

The Red Hat Process Automation Manager 7 - Business Central image requires a [Persistent Volume](https://docs.openshift.com/container-platform/3.7/architecture/additional_concepts/storage.html) which has both `ReadWriteOnce` (RWO) *and* `ReadWriteMany` (RWX) Access Types. If no PVs matching this description are available, deployment of that image will fail until a PV of that type is available.

---

### Automated installation
This installation option will install the Process Automation Manager 7 and Process Service in OpenShift using a single script, after which the demo project needs to be manually imported.

1. [Download and unzip](https://github.com/jbossdemocentral/rhpam7-mortgage-demo/archive/master.zip) or [clone this repo](https://github.com/jbossdemocentral/rhpam7-mortgage-demo.git).

2. Run the `init-openshift.sh` (Linux/macOS) or `init-openshift.ps1` (Windows) file. This will create a new project and application in OpenShift.

3. Login to your OpenShift console. For a local OpenShift installation this is usually: https://{host}:8443/console

4. Open the project "RHPAM7 Mortgage Demo". Open the "Overview" screen. Wait until the 2 pods, "rhpam7-mortgage-rhpamcentr" and "rhpam7-mortgage-kieserver" have been deployed.

5. Open the "Applications -> Routes" screen. Click on the "Hostname" value next to "rhpam7-mortgage-rhpamcentr". This opens the Business Central console.

6. Login to Business Central (u:pamAdmin, p:redhatpam1!)

7. The `Mortgage_Demo` project has been pre-installed in the `MySpace` spacethe installed and configured Red Hat Process Automation Manager 7 with the provisioned Mortgage Demo.

8. To run the demo, click on the *Deploy* button in the `Mortgage_Demo` project. After a successful build, a process instance can be started from the *Menu -> Manage -> Process Definitions* screen.


### Scripted installation
This installation option will install the Process Automation Manager 7 and Process Service in OpenShift using the provided `provision.sh` (Linux/macOS) or `provision.ps1` (Windows) script, which gives the user a bit more control how to provision to OpenShift.

1. [Download and unzip.](https://github.com/jbossdemocentral/rhpam7-install-demo/archive/master.zip) or [clone this repo](https://github.com/jbossdemocentral/rhpam7-mortgage-demo.git).

2. In the demo directory, go to `./support/openshift`. In that directory you will find the `provision.sh` (Linux/macOS) and `provision.ps1` (Windows) script.

3. Run `./provision.sh -h` (Linux/macOS) or `./provision.ps1 -h` (Windows) to inspect the installation options.

4. To provision the demo, with the OpenShift ImageStreams in the project's namespace, run `./provision.sh setup rhpam7-mortgage --with-imagestreams` (Linux/macOS) or `./provision.sh -command setup -demo rhpam7-mortgage -with-imagestreams` (Windows)

    ---
    **NOTE**

    The `with-imagestreams` parameter installs the Process Automation Manager 7 image streams and templates into the project namespace instead of the `openshift` namespace (for which you need admin rights). If you already have the required image-streams and templates installed in your OpenShift environment in the `openshift` namespace, you can omit the `with-imagestreams` from the setup command.

    ---

5. A second useful option is the `--pv-capacity` (Linux/macOS)/ `-pv-capacity` (Windows) option, which allows you to set the capacity of the _Persistent Volume_ used by the Business Central component. This is for example required when installing this demo in OpenShift Online, as the _Persistent Volume Claim_ needs to be set to `1Gi` instead of the default `512Mi`. So, to install this demo in OpenShift Online, you can use the following command: `./provision.sh setup rhpam7-mortgage --pv-capacity 1Gi --with-imagestreams` (Linux/macOS) or `./provision.ps1 -command setup -demo rhpam7-mortgage -pv-capacity 1Gi -with-imagestreams` (Windows).

6. After provisioning, follow the instructions from above "Option 2 - Automated installation", starting at step 3.

7. To delete an already provisioned demo, run `./provision.sh delete rhpam7-mortgage` (Linux/macOS) or `./provision.ps1 -command delete -demo rhpam7-mortgage` (Windows).

