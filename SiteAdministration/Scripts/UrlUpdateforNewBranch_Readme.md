When a new branch is created for a new PKS version, an existing branch is cloned, and all the URL's in the body of the documents on the newly cloned branch will still contain hard links to the old branch and need to have URL strings updated such that when users clicking a link from a document view of the new branch that directs to another document on the PKS ninja repo, it will direct to the document on the new feature branch and not the older branch. 

The following 2 commands can be executed from a bash shell at the root of the PKS-Ninja repository for the new branch and they will update the URL strings for each document in the directory structure beneath the location where the commands are executed. 

There are 2 commands because github sometimes provides URL's that include the string "tree/{branch name}" and other times includes the string "blob/{branch name}" in the same location in URL strings. It appears a user can arbitrarily replace "tree" with "blob" and the URL seems to work exactly the same, nonetheless some URLs in documents on the PKS Ninja repo include the string "blob" where other URLs include the string "tree". Accordingly there are 2 commands below, the first targets URLs with the "blob" string, the 2nd targets URL's with the "tree" string. 

```bash
find . -name '*.md' -exec sed -i -e 's/github.com\/CNA-Tech\/PKS-Ninja\/blob\/master/github.com\/CNA-Tech\/PKS-Ninja\/blob\/Pks1.4/g' {} \;

find . -name '*.md' -exec sed -i -e 's/github.com\/CNA-Tech\/PKS-Ninja\/tree\/master/github.com\/CNA-Tech\/PKS-Ninja\/tree\/Pks1.4/g' {} \;
```