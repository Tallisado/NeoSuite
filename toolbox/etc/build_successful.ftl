<#-- Uses FreeMarker template syntax, template guide can be found at http://freemarker.org/docs/dgui.html -->

<#import "common.ftl" as common>
<#import "responsibility.ftl" as resp>

<#global subject>[<@common.subjMarker/>, SUCCESSFUL] Build ${project.fullName} :: ${buildType.name} <@common.short_build_info build/></#global>

<#global body>Build ${project.fullName} :: ${buildType.name} <@common.short_build_info build/> successful ${var.buildShortStatusDescription}.
<@resp.buildTypeInvestigation buildType true/>
Agent: ${agentName}
Build results: ${link.buildResultsLink}

${var.buildCompilationErrors}${var.buildFailedTestsErrors}${var.buildChanges}
<@common.footer/></#global>

<#global bodyHtml>
<div>
  <div>
    Build <b>${project.fullName?html} :: ${buildType.name?html}</b> <a href='${link.buildResultsLink}'><@common.short_build_info build/></a> successful
    ${var.buildShortStatusDescription}
 
  <div style="color:blue">
    <code style="font-family:monospace;font-family:Menlo,Bitstream Vera Sans Mono,Courier New,Courier,monospace;font-size:12px">
        <#list build.buildLog.messages[(build.buildLog.messages?size - 30)..] as message>
            <#if message.text?trim?starts_with("      -- ")>
				${message.text?replace("\n", "\lbr/\g")?replace(" ", "&nbsp;")}<br/>
			</#if>            
        </#list>
    </code>
  </div>

  </div>
  <div><@resp.buildTypeInvestigation buildType true/></div>
  <@common.build_agent build/>
  <@common.build_comment build/>
  <br>
  <@common.build_changes var.changesBean/>
  <@common.compilation_errors var.compilationBean/>
  <@common.test_errors var.failedTestsBean/>
  <@common.footerHtml/>
</div>
</#global>
