define HELP_LICENSE

- Licensing
  - agpl
      Download AGPL v3 to LICENSE
  - apache
      Download Apache v2to LICENSE
  - gpl
      Download GPL v3 to LICENSE
  - lgpl
      Download LGPL v3 to LICENSE
  - mit
      Copy MIT to LICENSE
endef

HELP_TARGETS += ${HELP_LICENSE}

define MIT_LICENSE
MIT License

Copyright (c) $(shell date +%Y) [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
endef

define APACHE_LICENSE
Copyright $(shell date +%Y) [fullname]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
endef

agpl:
	@echo == Setting LICENSE to AGPL v3
	wget http://www.gnu.org/licenses/agpl-3.0.txt -O LICENSE

gpl:
	@echo == Setting LICENSE to GPL v3
	wget http://www.gnu.org/licenses/gpl-3.0.txt -O LICENSE

lgpl:
	@echo == Setting LICENSE to LGPL v3
	wget http://www.gnu.org/licenses/lgpl-3.0.txt -O LICENSE

apache:
	@echo == Setting LICENSE to Apache
	@echo -e "$(subst $(newline),\n,${APACHE_LICENSE})" \
	| sed "s/\[fullname\]/$$(getent passwd $$USER \
		| awk -F: '{print $$5}' \
		| awk -F, '{print $$1}')/;\
		s/\[year\]/$$(date +%Y)/" \
	> LICENSE

mit:
	@echo == Setting LICENSE to MIT
	@echo -e "$(subst $(newline),\n,${MIT_LICENSE})" \
	| sed "s/\[fullname\]/$$(getent passwd $$USER \
		| awk -F: '{print $$5}' \
		| awk -F, '{print $$1}')/;\
		s/\[year\]/$$(date +%Y)/" \
	> LICENSE
