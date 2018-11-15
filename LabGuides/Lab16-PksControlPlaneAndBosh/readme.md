# Lab 16 - PKS Control Plane and BOSH

**Contents:**

- [1.0 Create your first repo & basic operations]()
- [2.0 Branching, Forking and contributing to repositories]()

## 1.0 Create your first repo & basic operations

If you do not have a github account, go to github.com and follow the simple instructions on the homepage to create an account

In general it is a good practice to use a long-term personal email address when creating your account, as your github account and contributions you make reflect your professional reputation and you should when possible keep your account in the event of a change of employment as you would with a Linkedin account or resume. If you plan to become a regular practitioner in container and cloud native technologies, regardless of whether you have a developer or infrastructure focus, you should plan and make goals for yourself to become a regular contributor on github

Github is not just for coders, there is a huge need for non-code contributions and code contributions alike. Documentation, Reference architectures, tutorials, even fixing typos and so on, and each time you do your github profile reports the amount of contributions you make. Over time, this can become a huge enabler for achieving career goals and enhancing your professional and community profile

Github has tremendous practical benefits for infrastructure operations teams, for example you may personally use or know of others who use Docker hub as powerful and simple way to download and run an application. Github can be used in a very similar manner, as was demonstrated in lab 5 of this course where students download and run the Planespotter application.

As you observed with the planespotter application deployment, a user does not need to modify any files and can simply execute a few simple commands to run the planespotter application by cloning the github repo.  You can even run the planespotter deployment manifests directly from github.com without cloning the repo, and kubectl will resolve the external URL and deploy the application on your local kubernetes cluster.

Unlike docker hub however github is extremely flexible and can host infrastructure as code that can be customized for nearly any type of application or deployment need. Github hosts thousands of different containerized and kubernetes ready projects, a large percentage of which can simply be run in your PKS environment with no to minimal modification.

In this course, you will create and start making commits to repositories on github, and if you havent already, start to build your experience and reputation in this important technical community that is pervasive across cloud native technologies

VMware Cloud Native Business unit has a large amount of activity in open source communities, and are increasing our efforts to create more educational content in open github communities just like this course. As part of this effort, there are ample opportunities for contributors of all backgrounds and with any level of time commitment, even something as simple as fixing a typo can help increase your comfort and fluency with the tools while increasing your professional and community reputation, so please join in and take part in contributing to github.com/cna-tech projects

As noted in the lecture, git is not github, the latter is a company recently acquired by Microsoft that provides online git repository services. Git is an open source distributed version control system created by Linus Torvalds that is compatible with but does not require online or external git repository services. While github is the most commercially well known git repository, there are many others <!--and for VMware employees this lab guide will include a subsection on connecting to VMware's internal gitlab environment -->

### 1.1 Create local repo & push to github

**Stop:** Prior to beginning this lab, you should have a functional PKS deployment running in a non-production lab environment. For students following the Ninja course, all manual installation steps or pipeline installations for core PKS components should be completed in your lab environment before proceeding

1.1.0 Prepare your local git environment with your name and email address as shown in the following commands. Be sure to use your own name and the email address associated with your github account

```bash
git config --global user.name "Pablo Picasso"
git config --global user.email "PPicasso@fakemail.com"
```

<details><summary>Screenshot 1.1.0</summary>
<img src="Images/2018-11-14-02-56-16.png">
</details>
<br/>

1.1.1 From the control center desktop, use putty to connect and login to `cli-vm`. Make a new directory for a test repository and initialize the repository with the following commands

```bash
mkdir ~/TestRepo1
cd ~/TestRepo
git init
git status
```

Observe that the output of the `git status` command shows that you are currently on the branch master, you are still on your initial commit (you havent committed anything yet), and that you have not yet added anything to commit
