##########################GO-LICENSE-START################################
# Copyright 2014 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################GO-LICENSE-END##################################

class RepoViewModel
  attr_accessor :properties, :errors
  include RailsLocalizer

  def initialize(metadata, repository, plugin_id)
    @properties = []
    @errors = com.thoughtworks.go.domain.ConfigErrors.new
    unless metadata
      @errors.add("pluginId", l.string("ASSOCIATED_PLUGIN_NOT_FOUND", [plugin_id].to_java(java.lang.String)))
      return
    end

    package_configurations = metadata.list()
    package_configurations.each do |config|
      property = nil
      if repository
        property = repository.getConfiguration().getProperty(config.getKey())
      end
      @properties << PackagePropertyModel.new(config, property)
    end
  end
end

