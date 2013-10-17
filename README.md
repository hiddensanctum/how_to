#A "How-To" Site

By James Chuang
Rails Version 3.2.14

##Description

A simple "How-To" Site that explores the nested resources and how to route between them

##Instructions Key
* Change PARENT, CHILD, PROJECT_NAME to whatever you want to call them (DO NOT USE DEFAULT)
* \_B\_ means B is capitalized
* Be EXTRA careful of "s"
* \+ means add the code
* \- means delete it

##Instructions

###Create Brand New Rails App
```shell
$ rails _3.2.14_ new PROJECT_NAME --skip-test-framework
```
###Generate PARENT and CHILD scaffolds
```shell
$ rails generate scaffold PARENT_NAME title description:text --skip-test-framework
$ rails generate scaffold CHILD_NAME title description:text PARENT_id:integer --skip-test-framework
```
###Migrate your database
```shell
$ rake db:migrate
```
###Add PARENT and CHILD relationship
```shell
# in file app/models/PARENT.rb
class PARENT < ActiveRecord::Base
+ has_many :CHILDs

# in file app/models/CHILD.rb
class CHILD < ActiveRecord::Base
+ belongs_to :PARENT

# in file config/routes.rb
PROJECT_NAME::Application.routes.draw do
+ root :to =>"PARENT#index"
- resources :PARENT
- resources :CHILD
+ resources :PARENT do
+  resources :CHILD
+ end
```
###Modify CHILD controllers
```shell
# in file app/controllers/CHILD_controller.rb
class CHILDController < ApplicationController
+ before_filter :load_PARENT
def index
- @CHILDs = _C_HILD.all
+ @CHILDs = @PARENT.CHILDs.all

def show
- @CHILD = _C_HILD.find(params[:id])
+ @CHILD = @PARENT.CHILDs.find(params[:id])

def new
- @CHILD = _C_HILD.new
+ @CHILD = @PARENT.CHILDs.new

def edit
- @CHILD = _C_HILD.find(params[:id])
+ @CHILD = @PARENT.CHILDs.find(params[:id])

def create
- @CHILD = _C_HILD.new(params[:CHILD])
+ @CHILD = @PARENT.CHILDs.new(params[:CHILD])

- format.html { redirect_to @CHILD, notice: '_C_HILD was successfully created.' }
+ format.html { redirect_to [@PARENT, @CHILD], notice: '_C_HILD was successfully created.' }

def destroy
- @CHILD = _C_HILD.find(params[:id])
+ @CHILD = @PARENT.CHILDs.find(params[:id])

- format.html { redirect_to CHILDs_url }
+ format.html { redirect_to PARENT_CHILDs_path(@PARENT) }

+ private
+  def load_PARENT
+    @PARENT = __P__ARENT.find(params[:PARENT_id])
+  end
```
###Modify CHILD views
```shell
# in file app/views/CHILDs/_form.html.erb
- <%= form_for(@CHILD) do |f| %>
+ <%= form_for([@PARENT, @CHILD]) do |f| %>
```

```shell
# in file app/views/CHILDs/edit.html.erb
- <%= link_to 'Show', @CHILD %> |
- <%= link_to 'Back', CHILDs_path %>
+ <%= link_to 'Show', PARENT_CHILD_path(@PARENT, @CHILD) %> |
+ <%= link_to 'Back', PARENT_CHILDs_path(@PARENT) %>
```

```shell
# in file app/views/CHILDs/index.html.erb
- <td><%= link_to 'Show', CHILD %></td>
- <td><%= link_to 'Edit', edit_CHILD_path(CHILD) %></td>
- <td><%= link_to 'Destroy', CHILD, method: :delete, data: { confirm: 'Are you sure?' } %></td>
+ <td><%= link_to 'Show', PARENT_CHILD_path(@PARENT, CHILD) %></td>
+ <td><%= link_to 'Edit', edit_PARENT_CHILD_path(@PARENT, CHILD) %></td>
+ <td><%= link_to 'Destroy', [@PARENT, CHILD], method: :delete, data: { confirm: 'Are you sure?' } %></td>

- <%= link_to 'New _C_HILD', new_CHILD_path %>
+ <%= link_to 'New _C_HILD', new_PARENT_CHILD_path(@PARENT) %>
```

```shell
# in file app/views/CHILDs/new.html.erb
- <%= link_to 'Back', CHILDs_path %>
+ <%= link_to 'Back', PARENT_CHILDs_path(@PARENT) %>
```

```shell
# in file app/views/CHILDs/show.html.erb
- <%= link_to 'Edit', edit_CHILD_path(@CHILD) %> |
- <%= link_to 'Back', CHILDs_path %>
+ <%= link_to 'Edit', edit_PARENT_CHILD_path(@PARENT, @CHILD) %> |
+ <%= link_to 'Back', PARENT_CHILDs_path(@PARENT) %>
```
A Basic Barebone Nested Rails App should be made at this point

##Further Reading
* [Ruby on Rails Guide to Routing][1] specifically 2.7 Nested Resources
* [Tutorial on Creating Nested Resource][2] by [jhjguxin](https://gist.github.com/jhjguxin)

[1]: http://guides.rubyonrails.org/v3.2.13/routing.html
[2]: https://gist.github.com/jhjguxin/3074080
