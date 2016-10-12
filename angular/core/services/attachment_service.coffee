angular.module('loomioApp').factory 'AttachmentService', ($timeout) ->
  new class AttachmentService

    listenForAttachments: (scope, model) ->
      scope.$on 'disableAttachmentForm', -> scope.submitIsDisabled = true
      scope.$on 'enableAttachmentForm',  -> scope.submitIsDisabled = false
      scope.$on 'attachmentsAdded', (event, attachments) =>
        element = document.querySelector(scope.bodySelector)
        _.each attachments, (attachment) =>
          value = scope.comment.body
          if attachment.filename.match /\.(png|gif|jpg|jpeg)$/i
            scope.comment.body = value.substring(0, element.selectionStart) +
                                 "\n![attachment.filename](#{attachment.thumb})\n" +
                                 value.substring(element.selectionStart, value.length)
          else
            console.log('not an image!')
      scope.$on 'attachmentRemoved', (event, attachment) ->
        ids = model.newAttachmentIds
        ids.splice ids.indexOf(attachment.id), 1
        attachment.destroy() unless _.contains model.attachmentIds, attachment.id

    listenForPaste: (scope) ->
      scope.handlePaste = (event) ->
        data = event.clipboardData
        return unless item = _.first _.filter(data.items, (item) -> item.getAsFile())
        event.preventDefault()
        file = new File [item.getAsFile()], data.getData('text/plain'),
          lastModified: moment()
          type:         item.type
        scope.$broadcast 'attachmentPasted', file
