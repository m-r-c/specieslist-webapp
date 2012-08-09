 <!-- Template for diplaying a list of species list with or without a delete button -->
<div id="speciesList" class="speciesList">
    <script type="text/javascript">
        function deleteAction(){
            window.location.reload()
        }
    </script>
    <table>
    <thead>
    <tr>
        <td>List Name</td>
        <td>Owner</td>
        <td>Number of Items</td>
        <td/>
    </tr>
    </thead>
    <tbody>
    <g:each in="${lists}" var="list" status="i">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><a href="${request.contextPath}/speciesListItem/list/${list.dataResourceUid}">${fieldValue(bean: list, field: "listName")}</td>
            <td>${fieldValue(bean: list, field: "firstName")} ${fieldValue(bean: list, field: "surname")}</td>
            <td>${list.items.size()}</td>
            <g:if test="${list.username = request.getUserPrincipal()?.attributes?.email}">
                %{--<td id="delete${list.id}">--}%
                    %{--Delete--}%
                    %{--<a class="buttonDiv" href="#deleteList?listid=${list.id}">Delete</a>--}%
                    %{--<span class="button orange">--}%
                        %{--<g:form>--}%
                            %{--<g:hiddenField name="id" value="${list.id}"/>--}%
                            %{--<g:actionSubmit class="button orange" action="deleteList" value="Remove List" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>--}%
                        %{--</g:form>--}%
                    %{--</span>--}%
                %{--</td>--}%
                <td>
                <g:set var="test" value="${[id:list.id]}" />
                <gui:dialog
                        title="Delete ${list.listName}"
                        draggable="true"
                        form="true"
                        action="delete"
                        controller="speciesList"
                        id="dialog_${list.id}"
                        params="${test}"
                        buttons="[
                                [text:'Yes', handler: 'function(){this.submit();deleteAction();}', isDefault: false],
                                [text:'No', handler: 'function() {this.cancel();}', isDefault: true]
                        ]"
                        triggers="[show:[id:'delete_'+list.id, on:'click']]"
                >
                    Are you sure you would like to delete?
                </gui:dialog>
                    <a id="delete_${list.id}" class="buttonDiv">Delete</a>
                </td>
                %{--<gui:dialog--}%
                        %{--title='Delete ${list.listName}'--}%
                        %{--form='true'--}%
                        %{--action="delete"  controller="speciesList"--}%
                        %{--triggers="[show:[id:'delete' + list.id, on:'click']]"--}%
                        %{--buttons="[--}%
                                %{--[text:'Yes', handler: 'function() {this.submit();}', isDefault: true],--}%
                                %{--[text:'No', handler: 'function() {this.cancel();}', isDefault: false]--}%
                        %{--]">--}%
                    %{--Are you sure you would like to delete?--}%
                %{--</gui:dialog>--}%
            </g:if>
            <g:else><td/></g:else>
        </tr>
    </g:each>
    </tbody>
</table>
<g:if test="${params.max<total}">
    <div class="pagination">
        <g:paginate total="${total}" action="showList"  />
    </div>
</g:if>
</div>
