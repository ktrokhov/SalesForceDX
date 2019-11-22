<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>FU_SaveActualEventStart</fullName>
        <field>ActualStartDateTime__c</field>
        <formula>NOW()</formula>
        <name>Сохранение времени начала встречи</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_custom_Start_on_Event</fullName>
        <field>FactStartDateTime__c</field>
        <formula>ActivityDateTime</formula>
        <name>Updates custom Start on Event</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>01%2E Update custom Start time on Event</fullName>
        <actions>
            <name>Updates_custom_Start_on_Event</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.StartDateTime</field>
            <operation>greaterOrEqual</operation>
            <value>1/1/2018</value>
        </criteriaItems>
        <description>Копирует время из поля Start в кастомное поле Start на ивенте.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Сохранение реального времени начала встречи</fullName>
        <actions>
            <name>FU_SaveActualEventStart</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Status__c</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
