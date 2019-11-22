<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ActionEmail</fullName>
        <ccEmails>peshkov@gmail.com</ccEmails>
        <description>Отправка имейла при смене статуса Расчета КВ</description>
        <protected>false</protected>
        <recipients>
            <recipient>demo04072019@yandex.ru</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SupportCaseCreatedWebInquiries</template>
    </alerts>
</Workflow>
