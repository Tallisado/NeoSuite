<#-- Uses FreeMarker template syntax, template guide can be found at http://freemarker.org/docs/dgui.html -->

<#import "common.ftl" as common>
<#import "responsibility.ftl" as resp>

<#list build.buildLog.messages[1..] as message>
    <#if message.text?trim?starts_with('[TCRESULT]')>
        <#assign result=message.text?replace("[TCRESULT]=", "")>
	</#if>  
</#list>

<#global subject>[<@common.subjMarker/>, ${result}] Build ${project.fullName} :: ${buildType.name} </#global>

<#global body>Build ${project.fullName} :: ${buildType.name} <@common.short_build_info build/> ${result} ${var.buildShortStatusDescription}.
<@resp.buildTypeInvestigation buildType true/>
Agent: ${agentName}
Build results: ${link.buildResultsLink}

${var.buildCompilationErrors}${var.buildFailedTestsErrors}${var.buildChanges}
<@common.footer/></#global>

<#global bodyHtml>
<div>
  <div>
    Build:: <b>${project.fullName?html} :: ${buildType.name?html}</b> ${result}
    ${var.buildShortStatusDescription}
	<br/><br/><br/>
	
	<div style="color:blue">
	<code style="font-family:monospace;font-family:Menlo,Bitstream Vera Sans Mono,Courier New,Courier,monospace;font-size:12px">
	NeoSuite QuickReport:
	</code>
	<code style="font-family:monospace;font-family:Menlo,Bitstream Vera Sans Mono,Courier New,Courier,monospace;font-size:12px">
		<#list build.buildLog.messages[(build.buildLog.messages?size - 30)..] as message>
			<#if message.text?trim?starts_with('[TC]')>
			${message.text?replace("\n", "\lbr/\g")?replace(" ", "&nbsp;")?replace("[TC]", "    ")}<br/>
			</#if>            
		</#list>
	</code>
	<a href='${link.buildResultsLink}'>Click to view full report!</a>
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
