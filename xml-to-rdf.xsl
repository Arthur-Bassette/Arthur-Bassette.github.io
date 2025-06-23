<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:cv="http://example.org/cv-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    exclude-result-prefixes="xsl">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/CV">
        <rdf:RDF>
            <cv:Person rdf:about="http://example.org/cv/bassetter_arthur">
                <cv:fullName><xsl:value-of select="PersonalInfo/Name"/></cv:fullName>
                <xsl:if test="PersonalInfo/Name/@image">
                    <cv:hasPhoto rdf:resource="{PersonalInfo/Name/@image}"/>
                </xsl:if>
                <cv:phoneNumber><xsl:value-of select="PersonalInfo/Phone"/></cv:phoneNumber>
                <cv:emailAddress><xsl:value-of select="PersonalInfo/Email"/></cv:emailAddress>

                <xsl:for-each select="PersonalInfo/InternshipSearch/Duration/Lang">
                    <cv:internshipDuration xml:lang="{@id}"><xsl:value-of select="."/></cv:internshipDuration>
                </xsl:for-each>
                <xsl:for-each select="PersonalInfo/InternshipSearch/Period/Lang">
                    <cv:internshipPeriod xml:lang="{@id}"><xsl:value-of select="."/></cv:internshipPeriod>
                </xsl:for-each>

                <xsl:for-each select="ProfessionalSummary/Text/Lang">
                    <cv:summaryText xml:lang="{@id}"><xsl:value-of select="."/></cv:summaryText>
                </xsl:for-each>

                <xsl:for-each select="WorkExperience/Job">
                    <cv:hasJobExperience>
                        <cv:JobExperience rdf:about="http://example.org/cv/job/{generate-id()}">
                            <xsl:for-each select="Title/Lang">
                                <cv:title xml:lang="{@id}"><xsl:value-of select="."/></cv:title>
                            </xsl:for-each>
                            <cv:company><xsl:value-of select="Company"/></cv:company>
                            <cv:years><xsl:value-of select="Years"/></cv:years>
                            <xsl:for-each select="Responsibilities/Task/Lang">
                                <cv:hasResponsibility xml:lang="{@id}"><xsl:value-of select="."/></cv:hasResponsibility>
                            </xsl:for-each>
                        </cv:JobExperience>
                    </cv:hasJobExperience>
                </xsl:for-each>

                <xsl:for-each select="Education/Degree">
                    <cv:hasEducation>
                        <cv:Education rdf:about="http://example.org/cv/education/{generate-id()}">
                            <xsl:for-each select="Title/Lang">
                                <cv:title xml:lang="{@id}"><xsl:value-of select="."/></cv:title>
                            </xsl:for-each>
                            <xsl:for-each select="Institution/Lang">
                                <cv:institution xml:lang="{@id}"><xsl:value-of select="."/></cv:institution>
                            </xsl:for-each>
                            <xsl:if test="Type">
                                <xsl:for-each select="Type/Lang">
                                    <cv:studyType xml:lang="{@id}"><xsl:value-of select="."/></cv:studyType>
                                </xsl:for-each>
                            </xsl:if>
                            <cv:years><xsl:value-of select="Years"/></cv:years>
                        </cv:Education>
                    </cv:hasEducation>
                </xsl:for-each>

                <xsl:for-each select="TechnicalSkills/*"> <cv:hasSkillCategory>
                        <cv:SkillCategory rdf:about="http://example.org/cv/skillcat/{local-name()}">
                            <cv:title><xsl:value-of select="local-name()"/></cv:title> <xsl:for-each select="*"> <cv:includesSkill>
                                    <cv:Skill rdf:about="http://example.org/cv/skill/{generate-id()}">
                                        <cv:skillName><xsl:value-of select="."/></cv:skillName>
                                    </cv:Skill>
                                </cv:includesSkill>
                            </xsl:for-each>
                        </cv:SkillCategory>
                    </cv:hasSkillCategory>
                </xsl:for-each>

                <xsl:for-each select="Languages/Language">
                    <cv:hasLanguageProficiency>
                        <cv:LanguageProficiency rdf:about="http://example.org/cv/language/{generate-id()}">
                            <cv:languageName><xsl:value-of select="Name"/></cv:languageName>
                            <cv:languageLevel><xsl:value-of select="Level"/></cv:languageLevel>
                            <xsl:if test="Certification">
                                <cv:languageCertification><xsl:value-of select="Certification"/></cv:languageCertification>
                            </xsl:if>
                        </cv:LanguageProficiency>
                    </cv:hasLanguageProficiency>
                </xsl:for-each>

                <xsl:for-each select="Projects/Project">
                    <cv:hasProject>
                        <cv:Project rdf:about="http://example.org/cv/project/{generate-id()}">
                            <xsl:for-each select="Title/Lang">
                                <cv:title xml:lang="{@id}"><xsl:value-of select="."/></cv:title>
                            </xsl:for-each>
                            <cv:projectYear rdf:datatype="xsd:gYear"><xsl:value-of select="Year"/></cv:projectYear>
                            <xsl:for-each select="Description/Lang">
                                <cv:projectDescription xml:lang="{@id}"><xsl:value-of select="."/></cv:projectDescription>
                            </xsl:for-each>
                            <xsl:if test="Link">
                                <cv:projectLink rdf:resource="{Link}"/>
                            </xsl:if>
                            <xsl:if test="LoginInfo">
                                <xsl:for-each select="LoginInfo/Lang">
                                    <cv:projectLoginInfo xml:lang="{@id}"><xsl:value-of select="."/></cv:projectLoginInfo>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:if test="@image">
                                <cv:projectImage rdf:resource="{@image}"/>
                            </xsl:if>
                        </cv:Project>
                    </cv:hasProject>
                </xsl:for-each>

            </cv:Person>
        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>